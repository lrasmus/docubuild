json.array!(@sections) do |section|
  json.extract! section, :id, :title, :content, :status_id, :visibility_id, :created_by, :updated_by, :deleted_by, :document_id, :order
  json.url section_url(section, format: :json)
end
