class DocumentFilesController < ApplicationController
  before_action :set_document_file, only: [:show, :destroy]
  before_action :set_document, only: [:create]

  # POST /document_files
  # POST /document_files.json
  def create
    @document_file = DocumentFile.new(document_file_params)
    @document_file.document = @document
    respond_to do |format|
      if @document_file.save
        format.html { redirect_to edit_document_file_path(@document), notice: 'Document file was successfully created.' }
        format.json { render :show, status: :created, location: @document_file }
      else
        format.html { render :new }
        format.json { render json: @document_file.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_file
      @document_file = DocumentFile.find(params[:id])
    end

    def set_document
      @document = Document.find(params[:document_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_file_params
      params.require(:document_file).permit(:name, :document_file_type_id, :document_id, :content)
    end
end
