module Api  
  module V1
    class DocumentsController < BaseController
      def index
        render json: Document.all.where(created_by_id: current_user.id)
      end

      def show
        render json: Document.where(id: permitted_params[:id], created_by_id: current_user.id).first!
      end

      private

      def permitted_params
        params.permit(:id)
      end
    end
  end
end  