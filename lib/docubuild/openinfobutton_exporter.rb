require 'json'
require 'rest-client'
include Rails.application.routes.url_helpers

module DocUBuild
  class OpenInfobuttonExporter
    def map_context_category category
      if category == "mainSearchCriteria" or category == "subTopic"
        return category + ".v"
      elsif category == "taskContext" or category == "encounter"
        return category + ".c"
      end

      return category
    end

    def publish document, user
      base_url = Rails.configuration.x.docubuild.openinfobutton_base_url

      url_for_document = public_document_url(document)
      asset = {"namespaceCd" => "DocUBuild","displayName" => document.title,"lastUpdateDate" => document.updated_at,"assetUrl" => url_for_document,"assetMimeType" => "text/html"}

      response = JSON.parse(RestClient.get(base_url + "/assets?url=#{url_for_document}"))
      unless response.nil? or response.blank?
        puts response[0]
        asset["assetId"] = response[0]["assetId"]
      end

      response = RestClient.post(base_url + '/asset/update',
        asset.to_json,
        {content_type: :json, accept: :json})
      
      assetId = response.body.to_i
      return unless assetId > 0

      properties = []
      document.contexts.each do |context|
        properties << {"asset" => { "assetId" => assetId }, "propertyName" => map_context_category(context.category), "propertyType" => "CODE", "code" => context.code, "codeSystem" => context.code_system_oid, "displayName" => context.term, "generatedByCode" => user}
      end
      document.sections.each do |section|
        section.contexts.each do |context|
          properties << {"asset" => { "assetId" => assetId }, "propertyName" => map_context_category(context.category), "propertyType" => "CODE", "code" => context.code, "codeSystem" => context.code_system_oid, "displayName" => context.term, "generatedByCode" => user}
        end
      end
      RestClient.post(base_url + '/assetProperty/update',
        properties.to_json,
        {content_type: :json, accept: :json})
    end
  end
end