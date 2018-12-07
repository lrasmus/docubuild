require 'docubuild/infobutton_responder'
require 'docubuild/infobutton_request'

module Api
  module V1
    class InfobuttonRequestsController < BaseController
      resource_description do
        short 'Infobutton Responder'
        formats ['json']
      end

      api :GET, '/infobuttonRequests/search', "Perform an infobutton request to search for resources"
      param "mainSearchCriteria.v.c", String, required: true, desc: "Code of the main search criteria"
      param "mainSearchCriteria.v.cs", String, required: true, desc: "Code system of the main search criteria"
      param "patientPerson.administrativeGenderCode.c", String, desc: ""
      param "patientPerson.administrativeGenderCode.dn", String, desc: ""
      param "ageGroup.v.c", String, desc: ""
      param "ageGroup.v.cs", String, desc: ""
      param "ageGroup.v.dn", String, desc: ""
      param "taskContext.c.c", String, desc: ""
      param "taskContext.c.dn", String, desc: ""
      param "subTopic.v.c", String, desc: ""
      param "subTopic.v.cs", String, desc: ""
      param "subTopic.v.dn", String, desc: ""
      param "subTopic.v.ot", String, desc: ""
      param "mainSearchCriteria.v.dn", String, desc: ""
      param "mainSearchCriteria.v.ot", String, desc: ""
      param "severityObservation.interpretationCode.c", String, desc: ""
      param "severityObservation.interpretationCode.cs", String, desc: ""
      param "severityObservation.interpretationCode.dn", String, desc: ""
      param "informationRecipient", String, desc: ""
      param "performer", String, desc: ""
      param "performer.healthCareProvider.c.c", String, desc: ""
      param "performer.healthCareProvider.c.cs", String, desc: ""
      param "performer.healthCareProvider.c.dn", String, desc: ""
      param "informationRecipient.healthCareProvider.c.c", String, desc: ""
      param "informationRecipient.healthCareProvider.c.cs", String, desc: ""
      param "informationRecipient.healthCareProvider.c.dn", String, desc: ""
      param "performer.languageCode", String, desc: ""
      param "informationRecipient.languageCode.c", String, desc: ""
      param "encounter.c.c", String, desc: ""
      param "encounter.c.cs", String, desc: ""
      param "encounter.c.dn", String, desc: ""
      param "observation.c.c", String, desc: ""
      param "observation.c.cs", String, desc: ""
      param "observation.c.dn", String, desc: ""
      param "observation.v.c", String, desc: ""
      param "observation.v.cs", String, desc: ""
      param "observation.v.dn", String, desc: ""
      param "observation.v.v", String, desc: ""
      param "observation.v.u", String, desc: ""
      param "locationOfInterest.addr.ZIP", String, desc: ""
      param "locationOfInterest.addr.CTY", String, desc: ""
      param "locationOfInterest.addr.STA", String, desc: ""
      param "locationOfInterest.addr.CNT", String, desc: ""
      param "relevanceScore", String, desc: ""
      param "strengthOfRecommedation", String, desc: ""
      def search
        ib_request = DocUBuild::InfobuttonRequest.new(permitted_params)
        return Document.all.where(created_by_id: current_user.id) if ib_request.empty_search?

        ib_request.resolve_conflicting_parameters!

        responder = DocUBuild::InfobuttonResponder.new
        render json: responder.search(ib_request)
      end

      private
      def permitted_params
        params.permit("mainSearchCriteria.v.c", "mainSearchCriteria.v.cs", "patientPerson.administrativeGenderCode.c",
          "patientPerson.administrativeGenderCode.dn", "ageGroup.v.c", "ageGroup.v.cs", "ageGroup.v.dn", "taskContext.c.c",
          "taskContext.c.dn", "subTopic.v.c", "subTopic.v.cs", "subTopic.v.dn", "subTopic.v.ot", "mainSearchCriteria.v.dn",
          "mainSearchCriteria.v.ot", "severityObservation.interpretationCode.c", "severityObservation.interpretationCode.cs",
          "severityObservation.interpretationCode.dn", "informationRecipient", "performer", "performer.healthCareProvider.c.c",
          "performer.healthCareProvider.c.cs", "performer.healthCareProvider.c.dn", "informationRecipient.healthCareProvider.c.c",
          "informationRecipient.healthCareProvider.c.cs", "informationRecipient.healthCareProvider.c.dn", "performer.languageCode",
          "informationRecipient.languageCode.c", "encounter.c.c", "encounter.c.cs", "encounter.c.dn", "observation.c.c",
          "observation.c.cs", "observation.c.dn", "observation.v.c", "observation.v.cs", "observation.v.dn", "observation.v.v",
          "observation.v.u", "locationOfInterest.addr.ZIP", "locationOfInterest.addr.CTY", "locationOfInterest.addr.STA",
          "locationOfInterest.addr.CNT", "relevanceScore", "strengthOfRecommedation")
      end
    end
  end
end  