class SectionsController < ApplicationController
  include ContextsHelper
  include ApplicationHelper

  before_action :set_section, only: [:update, :destroy, :set_context, :template_sync, :clone_sync]

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    @section.title = @section.title || ""

    document = @section.document
    @section.order = 1
    unless document.sections.blank?
      @section.order = document.sections.last.order + 1
    end

    @section.visibility = document.visibility
    @section.status = document.status

    update_user_attribution @section, true

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        puts @section.errors.full_messages
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    update_user_attribution @section, false, true
    respond_to do |format|
      if @section.update(section_params)
        format.js do
          flash[:notice] = "Section was successfully updated"
          render layout: false
        end
        format.html { redirect_to edit_document_path(@section.document), notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { redirect_to edit_document_path(@section.document), notice: 'Failed to update section.' }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    # Save off a record of who performed the deletion before we proceed to destroy the record
    update_user_attribution @section, false, false, true
    @section.save

    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url, notice: 'Section was successfully destroyed.' }
      format.json { render text: "Section removed", status: :ok }
    end
  end

  def template_sync
    if params[:commit] == 'Apply'
      @section.sync_to_template
    end
    @section.template_version = @section.template.versions.last.id
    @section.save
    redirect_to edit_document_path(@section.document)
  end

  def clone_sync
    if params[:commit] == 'Apply'
      @section.sync_to_clone
    end
    @section.clone_source_version = @section.clone_source.versions.last.id
    @section.save
    redirect_to edit_document_path(@section.document)
  end

  # POST /sections/1/set_context
  def set_context
    set_contexts_for_item @section
    flash[:notice] = "Section context saved successfully"
    render "shared/ajax-flash"
    #render json: {result: 'OK'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:title, :content, :description, :status_id, :visibility_id, :document_id, :order,
        display_format:[:suppress_collapse, :collapse_default])
    end
end
