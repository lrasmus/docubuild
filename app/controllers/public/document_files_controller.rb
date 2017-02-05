module Public
  class DocumentFilesController < ApplicationController
    before_action :set_document_file, only: [:show]
      skip_before_filter :authenticate_user!, :only => [:show]

    # GET /document_files/1
    def show
      send_data(@document_file.content,
                  :filename => @document_file.name,
                  :type => @document_file.document_file_type.mime_type,
                  :disposition => "inline")
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_document_file
        @document_file = DocumentFile.find(params[:id])
      end
  end
end