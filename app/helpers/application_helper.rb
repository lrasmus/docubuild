module ApplicationHelper
  def update_user_attribution object, create, update = false, delete = false, user = nil
    user = user || current_user
    object.created_by = user if create
    object.updated_by = (update or delete) ? user : nil
    object.deleted_by = user if delete
  end
end
