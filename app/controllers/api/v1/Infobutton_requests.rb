require 'docubuild/infobutton_responder'
require 'docubuild/infobutton_request'

module API
  module V1
    class InfobuttonRequests < Grape::API
      include API::V1::Defaults

      resource :infobuttonRequests do
        desc "Performs an infobutton request for resources"
        params do
          requires "mainSearchCriteria.v.c", type: String, desc: "Code of the main search criteria"
          requires "mainSearchCriteria.v.cs", type: String, desc: "Code system of the main search criteria"

          optional "patientPerson.administrativeGenderCode.c", type: String, desc: ""
          optional "patientPerson.administrativeGenderCode.dn", type: String, desc: ""
          optional "ageGroup.v.c", type: String, desc: ""
          optional "ageGroup.v.cs", type: String, desc: ""
          optional "ageGroup.v.dn", type: String, desc: ""
          optional "taskContext.c.c", type: String, desc: ""
          optional "taskContext.c.dn", type: String, desc: ""
          optional "subTopic.v.c", type: String, desc: ""
          optional "subTopic.v.cs", type: String, desc: ""
          optional "subTopic.v.dn", type: String, desc: ""
          optional "subTopic.v.ot", type: String, desc: ""
          optional "mainSearchCriteria.v.dn", type: String, desc: ""
          optional "mainSearchCriteria.v.ot", type: String, desc: ""
          optional "severityObservation.interpretationCode.c", type: String, desc: ""
          optional "severityObservation.interpretationCode.cs", type: String, desc: ""
          optional "severityObservation.interpretationCode.dn", type: String, desc: ""
          optional "informationRecipient", type: String, desc: ""
          optional "performer", type: String, desc: ""
          optional "performer.healthCareProvider.c.c", type: String, desc: ""
          optional "performer.healthCareProvider.c.cs", type: String, desc: ""
          optional "performer.healthCareProvider.c.dn", type: String, desc: ""
          optional "informationRecipient.healthCareProvider.c.c", type: String, desc: ""
          optional "informationRecipient.healthCareProvider.c.cs", type: String, desc: ""
          optional "informationRecipient.healthCareProvider.c.dn", type: String, desc: ""
          optional "performer.languageCode", type: String, desc: ""
          optional "informationRecipient.languageCode.c", type: String, desc: ""
          optional "encounter.c.c", type: String, desc: ""
          optional "encounter.c.cs", type: String, desc: ""
          optional "encounter.c.dn", type: String, desc: ""
          optional "observation.c.c", type: String, desc: ""
          optional "observation.c.cs", type: String, desc: ""
          optional "observation.c.dn", type: String, desc: ""
          optional "observation.v.c", type: String, desc: ""
          optional "observation.v.cs", type: String, desc: ""
          optional "observation.v.dn", type: String, desc: ""
          optional "observation.v.v", type: String, desc: ""
          optional "observation.v.u", type: String, desc: ""
          optional "locationOfInterest.addr.ZIP", type: String, desc: ""
          optional "locationOfInterest.addr.CTY", type: String, desc: ""
          optional "locationOfInterest.addr.STA", type: String, desc: ""
          optional "locationOfInterest.addr.CNT", type: String, desc: ""
          optional "relevanceScore", type: String, desc: ""
          optional "strengthOfRecommedation", type: String, desc: ""
        end

        get :search do
          puts permitted_params.inspect
          ib_request = DocUBuild::InfobuttonRequest.new(permitted_params)
          return Document.all.where(created_by_id: current_user.id) if ib_request.empty_search?

          ib_request.resolve_conflicting_parameters!

          responder = DocUBuild::InfobuttonResponder.new
          responder.search ib_request

          #Document.where(created_by_id: current_user.id).first
          #[]
        end
      end
    end
  end
end  