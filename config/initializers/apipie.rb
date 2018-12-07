Apipie.configure do |config|
  config.app_name                = "DocUBuild - API"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidocs"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"

  config.default_version = "1"
  config.app_info = "The DocUBuild API will allow you to access documents, as well as perform queries in compliance with the HL7 Infobutton standard"

  config.translate               = false
  config.default_locale          = nil
end
