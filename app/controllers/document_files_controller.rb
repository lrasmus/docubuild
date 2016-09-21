class DocumentFilesController < ApplicationController
  before_action :set_document_file, only: [:show, :update, :destroy]
  before_action :set_document, only: [:create, :update]

  # GET /document_files/1
  def show
    send_data(@document_file.content,
                :filename => @document_file.name,
                :type => @document_file.document_file_type.mime_type,
                :disposition => "inline")
  end

  # POST /document_files
  # POST /document_files.json
  def create
    @document_file = DocumentFile.new(document_file_params)
    @document_file.document = @document
    # file_upload = params[:document_file][:content]
    # @document_file.name = file_upload.original_filename
    # @document_file.document_file_type = DocumentFileType.get_type_by_category(DocumentFileType::Logo, @document_file.name)
    # @document_file.content = file_upload.read
    respond_to do |format|
      if @document_file.save
        format.html { redirect_to edit_document_path(@document), notice: 'Document file was successfully created.' }
        format.json { render :show, status: :created, location: @document_file }
      else
        format.html { render :new }
        format.json { render json: @document_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_files/1
  # PATCH/PUT /document_files/1.json
  def update
    # file_upload = params[:document_file][:content]
    # @document_file.name = file_upload.original_filename
    # @document_file.document_file_type = DocumentFileType.get_type_by_category(DocumentFileType::Logo, @document_file.name)
    # @document_file.content = file_upload.read
    respond_to do |format|
      if @document_file.update(document_file_params)
        format.html { redirect_to edit_document_path(@document), notice: 'Document file was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_file }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
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
      doc_params = params.require(:document_file).permit(:name, :document_file_type_id, :document_id, :content)
      if (doc_params.has_key?(:content))
        file_upload = doc_params.delete(:content)
        doc_params[:name] = sanitize_filename(file_upload.original_filename)
        doc_params[:document_file_type_id] = DocumentFileType.get_type_by_category(DocumentFileType::Logo, doc_params[:name]).id
        doc_params[:content] = file_upload.read
      end

      doc_params
    end

    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
    end
end
