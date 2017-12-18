require 'docubuild/context_match'

module DocUBuild
  class InfobuttonResponder

    # Given a collection of Context results, initialize what will be our main collection of
    # matches - factoring in documents linked to matched sections, and sections linked to
    # matched documents.
    def initialize_matches contexts
      matches = {}
      return matches if contexts.blank?

      contexts.each do |context|
        item = context.item
        matches[item] = [] if matches[item].nil?
        matches[item] << ContextMatch.new(context, ContextMatch::DirectMatch)
        matches = expand_match matches, context
        # matches = matches.merge(expand_section_match(context, item)) if item.is_a?(Section)
        # matches = matches.merge(expand_document_match(context, item)) if item.is_a?(Document)
      end
      matches
    end

    def expand_match matches, context
      item = context.item
      matches = matches.merge(expand_section_match(context,item)) {|key, oldval, newval| oldval.concat(newval) } if item.is_a?(Section)
      matches = matches.merge(expand_document_match(context, item)) {|key, oldval, newval| oldval.concat(newval) } if item.is_a?(Document)
      matches
    end

    def expand_section_match context, section
      inherited_matches = {}
      # First, get the associated document and add that to our collection
      inherited_matches[section.document] = [] if inherited_matches[section.document].nil?
      #puts section.document
      #puts inherited_matches.inspect
      inherited_matches[section.document] << ContextMatch.new(context, ContextMatch::InheritedMatch)
      # Loop through the rest of the document's sections (minus the context one) and also add those to
      # our inherited collection
      section.document.sections.select{|s| s.id != section.id}.each do |s|
        inherited_matches[s] = [] if inherited_matches[s].nil?
        inherited_matches[s] << ContextMatch.new(context, ContextMatch::InheritedMatch)
      end

      inherited_matches
    end

    def expand_document_match context, document
      inherited_matches = {}
      document.sections.each do |section|
        inherited_matches[section] = [] if inherited_matches[section].nil?
        inherited_matches[section] << ContextMatch.new(context, ContextMatch::InheritedMatch)
      end
      inherited_matches
    end

    def sub_query_terms base_query, string
      sub_query = base_query.where("term ilike ?", "%#{string}%")
      return sub_query.select(:item_id, :item_type).to_a
    end

    def perform_match_to_context matches, category, code_system_oid, code
      matches.each do |item, contexts|
        result = Context.where(category: category)
              .where(code_system_oid: code_system_oid)
              .where(code: code)
              .where(item_id: item.id)
              .where(item_type: item.class.name).first
        unless result.nil?
          matches[item] << ContextMatch.new(result, ContextMatch::DirectMatch)
          matches = expand_match matches, result
          #puts "******** perform_match_to_context"
          #matches.each{ |k, v| puts "*** #{k.class.name} #{v.count}"}
        end
      end
      matches
    end

    def match_task_context matches, ib_request
      return matches if ib_request.taskContextCode.blank?
      perform_match_to_context matches, "taskContext", "2.16.840.1.113883.5.4", ib_request.taskContextCode
      # return matches if ib_request.nil? or ib_request.taskContextCode.blank?
      # matches.each do |item, contexts|
      #   result = Context.where(category: "taskContext")
      #         .where(code_system_oid: "2.16.840.1.113883.5.4")
      #         .where(code: ib_request.taskContextCode)
      #         .where(item_id: item.id)
      #         .where(item_type: item.class.name).first
      #   matches[item] << ContextMatch.new(result, ContextMatch::DirectMatch) unless result.nil?
      # end
      # matches
    end

    def match_sub_topic_context matches, ib_request
      return matches if ib_request.subTopicCode.blank? or ib_request.subTopicCodeSystem.blank?
      perform_match_to_context matches, "subTopic", ib_request.subTopicCodeSystem, ib_request.subTopicCode
      # return matches if ib_request.nil? or ib_request.subTopicCode.blank? or ib_request.subTopicCodeSystem.blank?
      # matches.each do |item, contexts|
      #   result = Context.where(category: "subTopic")
      #         .where(code_system_oid: ib_request.subTopicCodeSystem)
      #         .where(code: ib_request.subTopicCode)
      #         .where(item_id: item.id)
      #         .where(item_type: item.class.name).first
      #   matches[item] << ContextMatch.new(result, ContextMatch::DirectMatch) unless result.nil?
      # end
      # matches
    end

    def match_gender_context matches, ib_request
      return matches if ib_request.patientPersonAdministrativeGenderCodeCode.blank?
      perform_match_to_context matches, "administrativeGenderCode", "2.16.840.1.113883.5.1", ib_request.patientPersonAdministrativeGenderCodeCode
    end

    def match_age_context matches, ib_request
      return matches if ib_request.ageGroupCode.blank? or ib_request.ageGroupCodeSystem.blank?
      perform_match_to_context matches, "ageGroup", ib_request.ageGroupCodeSystem, ib_request.ageGroupCode
    end

    def match_severity_observation_context matches, ib_request
      return matches if ib_request.severityObservationInterpretationCodeCode.blank? or ib_request.severityObservationInterpretationCodeCodeSystem.blank?
      perform_match_to_context matches, "severityObservation", ib_request.severityObservationInterpretationCodeCodeSystem, ib_request.severityObservationInterpretationCodeCode
    end

    def match_information_recipient_context matches, ib_request
      return matches if ib_request.severityObservationInterpretationCodeCode.blank? or ib_request.severityObservationInterpretationCodeCodeSystem.blank?
      perform_match_to_context matches, "informationRecipient", "2.16.840.1.113883.5.110", ib_request.informationRecipient
    end

    def match_encounter_context matches, ib_request
      return matches if ib_request.encounterCode.blank? or ib_request.encounterCodeSystem.blank?
      perform_match_to_context matches, "encounter", ib_request.encounterCodeSystem, ib_request.encounterCode
    end

    def search ib_request
      return [] if ib_request.nil?

      query = Context.all
      # The main search criteria code and code system are required, so add those in first
      query = query.where(category: "mainSearchCriteria")
                    .where(code: ib_request.mainSearchCriteriaCode)
                    .where(code_system_oid: ib_request.mainSearchCriteriaCodeSystem)
                    #.where("term ilike ?", "%#{ib_request.mainSearchCriteriaDisplayName}%")

      # The matches collection is a Hash, where the key is the item (Document or Section) that
      # is the match, and the key is an array of ContextMatch items
      matches = initialize_matches(query.to_a)
      matches = match_task_context(matches, ib_request)
      matches = match_sub_topic_context(matches, ib_request)
      matches = match_gender_context(matches, ib_request)
      matches = match_age_context(matches, ib_request)
      matches = match_severity_observation_context(matches, ib_request)
      matches = match_information_recipient_context(matches, ib_request)
      matches = match_encounter_context(matches, ib_request)

      # Find the max score for all of the items we attempted to match
      max_score = matches.values.map { |v| v.count }.max

      # Find the document(s) with a max score.  Note that we consider a document inheriting
      # a section's context as the same score as that maximum section score.  This should be
      # reflected in the score already (since defining context matches includes inheritance),
      # so we just match directly on max score.
      max_score_documents = matches.select { |key, value| value.count == max_score && key.class.name == 'Document' }

      # For the documents that are top matches, we now want to factor in inheritance on all
      # of the sections and give them a relevance score
      max_score_documents.each do |document, contexts|
        document.sections.each do |section|
          contexts = matches[section]
          section.relevance_score = (contexts.select{|c| c.match_type == ContextMatch::DirectMatch }.count * 1.0 +
            contexts.select{|c| c.match_type == ContextMatch::InheritedMatch }.count * 0.5) / max_score
        end
      end

      # We return just the list of documents here - context matching results are really just used
      # internally to this class
      max_score_documents.keys
    end
  end
end