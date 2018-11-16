module Public
  class DocumentsController < ApplicationController
    before_action :set_document, only: [:show]
    skip_before_filter :authenticate_user!, :only => [:index, :show]

    # GET /documents
    # GET /documents.json
    def index
      @documents = Document.not_templates.publicly_available
      render layout: "layouts/public"
    end

    # GET /documents/1
    # GET /documents/1.json
    def show
      if @document.is_publicly_available?
        render layout: "layouts/public"
      else
        redirect_to public_documents_url
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_document
        @document = Document.find(params[:id])
      end
  end
end