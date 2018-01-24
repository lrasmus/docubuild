module API  
  module V1
    class Documents < Grape::API
      include API::V1::Defaults

      resource :documents do
        desc "Return all documents that the user has access to"
        get "", root: :documents do
          Document.all.where(created_by_id: current_user.id)
        end

        desc "Return a document"
        params do
          requires :id, type: String, desc: "ID of the document"
        end
        get ":id", root: "document" do
          Document.where(id: permitted_params[:id], created_by_id: current_user.id).first!
        end
      end
    end
  end
end  