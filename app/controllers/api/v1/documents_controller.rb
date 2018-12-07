module Api  
  module V1
    class DocumentsController < BaseController
      resource_description do
        short 'DocUBuild authored documents'
        formats ['json']
      end

      api :GET, '/documents', "Return all documents the currently authenticated user has access to"
      def index
        render json: Document.clonable_by_user(current_user)
      end

      api :GET, '/documents/:id', "Return a specific document"
      param :id, :number, required: true, :desc => "The document ID to retrieve"
      def show
        render json: Document.clonable_by_user(current_user).where(id: permitted_params[:id]).first!
      end

      private

      def permitted_params
        params.permit(:id)
      end
    end
  end
end  