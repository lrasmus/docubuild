json.array!(@folders) do |folder|
  json.extract! folder, :id, :title, :description, :status_id, :visibility_id, :created_by, :updated_by, :deleted_by, :parent, :owner
  json.url folder_url(folder, format: :json)
end
