module API  
  module V1
    class Documents < API::V1::Base
      def index
        Document.all.where(created_by_id: current_user.id)
      end

      def show
        Document.where(id: permitted_params[:id], created_by_id: current_user.id).first!
      end
    end
  end
end  