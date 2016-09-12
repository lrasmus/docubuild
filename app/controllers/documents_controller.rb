class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :template_sections, :add_sections_from_templates]
  before_filter :check_for_cancel, :only => [:create, :update]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.not_templates
  end

  # GET /documents/1/template_sections[?missing_only]
  def template_sections
    @templated = !@document.template.blank?
    @sections = []
    if @templated
      @open_template = @document.template.sections.blank?

      allowed_sections = @document.template.sections
      if params.has_key?(:missing_only)
        @sections = allowed_sections.select { |as| !@document.sections.any? { |ds| ds.template_id == as.id } }
      else
        @sections = allowed_sections
      end
    end

    respond_to do |format|
      format.html { render "template_sections", layout: false }
    end
  end

  # POST /documents/1/add_sections_from_templates
  def add_sections_from_templates
    # TODO verify the template sections are in the document template

    section_ids = params[:sections]
    unless section_ids.empty?
      section_ids.each do |id|
        section = Section.find_by_id(id)
        puts "#{section}"
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

  # GET /documents/1
  # GET /documents/1.json
  def show
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

    success = @document.save
    if success and !@document.template_id.nil?
      template = Document.find_by_id(@document.template_id)
      # Copy all of the sections from the original template
      template.sections.each do |section|
        new_section = section.dup
        new_section.document = @document
        new_section.template = section
        success = success and new_section.save
      end
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
      params.require(:document).permit(:title, :description, :institution, :status_id, :visibility_id, :created_by, :updated_by, :deleted_by, :folder_id, :template_id)
    end

    def check_for_cancel
      if params[:cancel]
        redirect_to documents_path
      end
    end

end
