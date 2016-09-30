require 'docubuild/html_exporter'

class DocumentsController < ApplicationController
  include ContextsHelper

  before_action :set_document, only: [:show, :edit, :update, :destroy, :template_sections, :add_sections_from_templates, :import_sections, :preview, :set_context, :deploy]
  before_filter :check_for_cancel, :only => [:create, :update, :clone]
  before_filter :clean_view_param, :only => [:template_sections]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.not_templates
  end

  # GET /documents/1/template_sections[?missing_only=true|false][view=default|preview|select]
  def template_sections
    @templated = !@document.template.blank?
    @sections = []
    if (params[:view] == "preview")
      @sections = @document.sections
    elsif @templated
      @open_template = @document.template.sections.blank?

      allowed_sections = @document.template.sections
      if params.has_key?(:missing_only)
        @sections = allowed_sections.select { |as| !@document.sections.any? { |ds| ds.template_id == as.id } }
      else
        @sections = allowed_sections
      end
    end

    respond_to do |format|
      format.html { render (params[:view] == "preview") ? "_preview_template_sections" : "_select_template_sections", layout: false }
      format.json { render json: @sections }
    end
  end

  # POST /documents/1/add_sections_from_templates
  def add_sections_from_templates
    # TODO verify the template sections are in the document template
    section_ids = params[:sections]
    unless section_ids.empty?
      section_ids.each do |id|
        section = Section.find_by_id(id)
        if (section)
          new_section = section.dup
          new_section.document = @document
          new_section.template = section
          new_section.save
        end
      end
    end

    respond_to do |format|
      format.json { render json: @document.sections, status: :created }
    end
  end

  # GET /documents/select_clone
  def select_clone
    @document = Document.new
    @documents = Document.not_templates
  end

  # POST /documents/clone
  def clone
    clone_source_id = params[:document][:clone_source_id]
    if clone_source_id
      success = clone_document(clone_source_id)
    else
      @document = Document.new
      @document.status_id = Status::InProgress
      @document.visibility_id = 1
      success = @document.save
    end

    respond_to do |format|
      if success
        format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :import }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /documents/1/import_sections
  def import_sections
    @documents = Document.not_templates
    render :partial => "import_sections"
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/1
  def preview
    render :partial => "preview"
  end

  # GET /documents/new
  def new
    @document = Document.new
    @templates = Document.templates
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.style = default_style if @document.style.nil?

    success = @document.save
    if success and !@document.template_id.nil?
      template = Document.find_by_id(@document.template_id)
      success = duplicate_sections_from_document(@document, template) &&
        duplicate_contexts_from_document(@document, template) &&
        duplicate_document_files_from_document(@document, template)
    end

    respond_to do |format|
      if success
        format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /documents/1/set_context
  def set_context
    set_contexts_for_item @document
    render json: {result: 'OK'}, status: :ok
  end

  # GET /documents/1/deploy
  def deploy
    exporter = DocUBuild::HtmlExporter.new
    temp_file = exporter.export_document(@document, (render_to_string :partial => "preview"))
    unless temp_file.nil?
      temp_file.open
      send_data temp_file.read, filename: "document_#{@document.id}.zip"
      temp_file.unlink
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :description, :institution, :status_id, :visibility_id, :created_by, :updated_by, :deleted_by, :folder_id, :template_id, style:[:font_name, :font_size, :font_color])
    end

    def clean_view_param
      params[:view] = "default" unless params.has_key?(:view)
      return if params[:view] == "preview" or params[:view] == "select" or params[:view] == "default"
      params[:view] = "default"
    end

    def check_for_cancel
      if params[:cancel]
        redirect_to documents_path
      end
    end

    # Cloning may be a true clone of an existing document, or it may be a clone of a template.  When
    # a clone action is taken for a template, we create a new instance of the document from that
    # template but do not set the clone source.
    def clone_document clone_source_id
      clone_doc = Document.find_by_id(clone_source_id)
      @document = clone_doc.dup
      @document.status_id = Status::InProgress
      @document.is_template = false   # Even if we're cloning from a template, we're creating a new document, not a template
      @document.template_id = (clone_doc.is_template? ? clone_doc.id : clone_doc.template_id)
      @document.clone_source = (clone_doc.is_template ? nil : clone_doc)
      success = @document.save &&
        duplicate_sections_from_document(@document, clone_doc) &&
        duplicate_document_files_from_document(@document, clone_doc) &&
        duplicate_contexts_from_document(@document, clone_doc)
    end

    def duplicate_sections_from_document document, template
      success = true
      is_true_template = template.template_id.blank?
      template.sections.each do |section|
        new_section = section.dup
        new_section.document = document
        new_section.template = (is_true_template ? section : section.template)
        success = success and new_section.save
      end

      success
    end

    def duplicate_document_files_from_document document, template
      success = true
      template.document_files.each do |file|
        new_file = file.dup
        new_file.document = document
        success = success and new_file.save
      end
      success
    end

    def duplicate_contexts_from_document document, template
      success = true
      template.contexts.each do |context|
        new_context = context.dup
        new_context.item = document
        success = success and new_context.save
      end
      success
    end

    def default_style
      {"font_name" => "Arial", "font_size" => "11", "font_color" => "#000000"}
    end
end
