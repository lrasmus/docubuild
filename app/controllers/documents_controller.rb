class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :template_sections, :add_sections_from_templates, :import_sections, :preview]
  before_filter :check_for_cancel, :only => [:create, :update, :create_import]
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

  # GET /documents/import
  def import
    @document = Document.new
    @documents = Document.all
  end

  # POST /documents/create_import
  def create_import
    template_id = params[:document][:template_id]
    if template_id
      template = Document.find_by_id(template_id)
      @document = template.dup
      @document.status_id = Status::InProgress
      @document.is_template = false   # Even if we're importing from a template, we're creating a new document, not a template
      @document.template_id = (template.template_id.blank? ? template.id : template.template_id)
      success = @document.save && duplicate_sections_from_template(@document, template)
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
      success = duplicate_sections_from_template(@document, template)
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

    def duplicate_sections_from_template document, template
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

    def default_style
      {"font_name" => "Arial", "font_size" => "11", "font_color" => "#000000"}
    end
end
