require 'docubuild/context_match'

module DocUBuild
  class InfobuttonResponder

    # Given a collection of Context results, initialize what will be our main collection of
    # matches - factoring in documents linked to matched sections, and sections linked to
    # matched documents.
    def initialize_matches contexts
      matches = []
      return matches if contexts.blank?

      contexts.each do |context|
        item = context.item
        matches << ContextMatch.new(item, ContextMatch::DirectMatch)
        matches << expand_section_match(item) if item.is_a?(Section)
        matches << expand_document_match(item) if item.is_a?(Document)
      end

      matches.flatten
    end

    def expand_section_match section
      inherited_matches = []
      # First, get the associated document and add that to our collection
      inherited_matches << ContextMatch.new(section.document, ContextMatch::InheritedMatch)
      # Loop through the rest of the document's sections (minus the context one) and also add those to
      # our inherited collection
      section.document.sections.select{|s| s.id != section.id}.each do |s|
        inherited_matches << ContextMatch.new(s, ContextMatch::InheritedMatch)
      end

      inherited_matches
    end

    def expand_document_match document
      inherited_matches = []
      document.sections.each do |section|
        inherited_matches << ContextMatch.new(section, ContextMatch::InheritedMatch)
      end
      inherited_matches
    end

    def sub_query_terms base_query, string
      sub_query = base_query.where("term ilike ?", "%#{string}%")
      return sub_query.select(:item_id, :item_type).to_a
    end

    def match_task_context matches, ib_request
      return matches if ib_request.nil? or ib_request.taskContextCode.blank?
      matches.each do |match|
        query = Context.where(category: "taskContext")
              .where(code_system_oid: "2.16.840.1.113883.5.4")
              .where(code: ib_request.taskContextCode)
              .where(item_id: match.item.id)
              .where(item_type: match.item.class.name).to_a
      end
      matches
    end

    def match_sub_topic_context matches, ib_request
      return matches if ib_request.nil? or ib_request.subTopicCode.blank? or ib_request.subTopicCodeSystem.blank?
      matches.each do |m|
        query = Context.where(category: "subTopic")
              .where(code_system_oid: ib_request.subTopicCodeSystem)
              .where(code: ib_request.subTopicCode)
              .where(item_id: m.item.id)
              .where(item_type: m.item.class.name).to_a
      end
      matches
    end

    def search ib_request
      query = Context.all
      # The main search criteria code and code system are required, so add those in first
      query = query.where(category: "mainSearchCriteria")
                    .where(code: ib_request.mainSearchCriteriaCode)
                    .where(code_system_oid: ib_request.mainSearchCriteriaCodeSystem)
                    #.where("term ilike ?", "%#{ib_request.mainSearchCriteriaDisplayName}%")

      matches = initialize_matches(query.to_a)
      matches = match_task_context(matches, ib_request)
      matches = match_sub_topic_context(matches, ib_request)

      matches
    end
  end
end