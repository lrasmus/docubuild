module DocUBuild
  class InfobuttonRequest
    # Attributes are named according to their URL parameter names.  Some of them may appear odd - for example,
    # "observationCodeCode" - "Code" is duplicated, but this is because it represents "observation.c.c", which
    # is the code of the observation code.  This helps distinguish observation code from observation value.
    attr_accessor :mainSearchCriteriaCode, :mainSearchCriteriaCodeSystem, :mainSearchCriteriaDisplayName, :mainSearchCriteriaOriginalText,\
      :patientPersonAdministrativeGenderCodeCode, :patientPersonAdministrativeGenderCodeDisplayName,\
      :ageGroupCode, :ageGroupCodeSystem, :ageGroupDisplayName,\
      :taskContextCode, :taskContextDisplayName,\
      :subTopicCode, :subTopicCodeSystem, :subTopicDisplayName, :subTopicOriginalText,\
      :severityObservationInterpretationCodeCode, :severityObservationInterpretationCodeCodeSystem, :severityObservationInterpretationCodeDisplayName,\
      :informationRecipient,\
      :performer, :performerHealthCareProviderCode, :performerHealthCareProviderCodeSystem, :performerHealthCareProviderDisplayName,\
      :informationRecipientHealthCareProviderCode, :informationRecipientHealthCareProviderCodeSystem, :informationRecipientHealthCareProviderDisplayName,\
      :performerLanguageCode, :informationRecipientLanguageCodeCode,\
      :encounterCode, :encounterCodeSystem, :encounterDisplayName,\
      :observationCodeCode, :observationCodeCodeSystem, :observationCodeDisplayName,\
      :observationValueCode, :observationValueCodeSystem, :observationValueDisplayName, :observationValueValue, :observationValueUnit,\
      :locationOfInterestAddrZIP, :locationOfInterestAddrCTY, :locationOfInterestAddrSTA, :locationOfInterestAddrCNT,\
      :relevanceScore,\
      :strengthOfRecommedation

    def initialize params
      @mainSearchCriteriaCode = params["mainSearchCriteria.v.c"]
      @mainSearchCriteriaCodeSystem = params["mainSearchCriteria.v.cs"]
      @mainSearchCriteriaDisplayName = params["mainSearchCriteria.v.dn"]
      @mainSearchCriteriaOriginalText = params["mainSearchCriteria.v.ot"]
      @patientPersonAdministrativeGenderCodeCode = params["patientPerson.administrativeGenderCode.c"]
      @patientPersonAdministrativeGenderCodeDisplayName = params["patientPerson.administrativeGenderCode.dn"]
      @ageGroupCode = params["ageGroup.v.c"]
      @ageGroupCodeSystem = params["ageGroup.v.cs"]
      @ageGroupDisplayName = params["ageGroup.v.dn"]
      @taskContextCode = params["taskContext.c.c"]
      @taskContextDisplayName = params["taskContext.c.dn"]
      @subTopicCode = params["subTopic.v.c"]
      @subTopicCodeSystem = params["subTopic.v.cs"]
      @subTopicDisplayName = params["subTopic.v.dn"]
      @subTopicOriginalText = params["subTopic.v.ot"]
      @severityObservationInterpretationCodeCode = params["severityObservation.interpretationCode.c"]
      @severityObservationInterpretationCodeCodeSystem = params["severityObservation.interpretationCode.cs"]
      @severityObservationInterpretationCodeDisplayName = params["severityObservation.interpretationCode.dn"]
      @informationRecipient = params["informationRecipient"]
      @performer = params["performer"]
      @performerHealthCareProviderCode = params["performer.healthCareProvider.c.c"]
      @performerHealthCareProviderCodeSystem = params["performer.healthCareProvider.c.cs"]
      @performerHealthCareProviderDisplayName = params["performer.healthCareProvider.c.dn"]
      @informationRecipientHealthCareProviderCode = params["informationRecipient.healthCareProvider.c.c"]
      @informationRecipientHealthCareProviderCodeSystem = params["informationRecipient.healthCareProvider.c.cs"]
      @informationRecipientHealthCareProviderDisplayName = params["informationRecipient.healthCareProvider.c.dn"]
      @performerLanguageCode = params["performer.languageCode"]
      @informationRecipientLanguageCodeCode = params["informationRecipient.languageCode.c"]
      @encounterCode = params["encounter.c.c"]
      @encounterCodeSystem = params["encounter.c.cs"]
      @encounterDisplayName = params["encounter.c.dn"]
      @observationCodeCode = params["observation.c.c"]
      @observationCodeCodeSystem = params["observation.c.cs"]
      @observationCodeDisplayName = params["observation.c.dn"]
      @observationValueCode = params["observation.v.c"]
      @observationValueCodeSystem = params["observation.v.cs"]
      @observationValueDisplayName = params["observation.v.dn"]
      @observationValueValue = params["observation.v.v"]
      @observationValueUnit = params["observation.v.u"]
      @locationOfInterestAddrZIP = params["locationOfInterest.addr.ZIP"]
      @locationOfInterestAddrCTY = params["locationOfInterest.addr.CTY"]
      @locationOfInterestAddrSTA = params["locationOfInterest.addr.STA"]
      @locationOfInterestAddrCNT = params["locationOfInterest.addr.CNT"]
      @relevanceScore = params["relevanceScore"]
      @strengthOfRecommedation = params["strengthOfRecommedation"]
    end

    def resolve_conflicting_parameters!
      # If both performer and recipient languages are specified, recipient wins out
      if !@performerLanguageCode.blank? && !@informationRecipientLanguageCodeCode.blank?
        @performerLanguageCode = nil
      end

      # If both performer and recipient healthcare provider codes are specified, recipient wins out
      if !@performerHealthCareProviderCode.blank? && !@informationRecipientHealthCareProviderCode.blank?
        @performerHealthCareProviderCode = nil
        @performerHealthCareProviderCodeSystem = nil
        @performerHealthCareProviderDisplayName = nil
      end
    end

    def empty_search?
      self.instance_values.all? { |attribute| attribute[1].blank? }
    end
  end
end