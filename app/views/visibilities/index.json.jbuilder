json.array!(@visibilities) do |visibility|
  json.extract! visibility, :id, :name
  json.url visibility_url(visibility, format: :json)
end
