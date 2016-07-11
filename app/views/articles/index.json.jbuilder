json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :status_id, :visibility_id, :created_by_id, :updated_by_id, :deleted_by_id, :folder_id, :template_id
  json.url article_url(article, format: :json)
end
