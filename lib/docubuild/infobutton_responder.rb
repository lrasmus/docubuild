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

      matches
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

    def search ib_request
      query = Context.all
      # The main search criteria code and code system are required, so add those in first
      query = query.where(category: "mainSearchCriteria")
                    .where(code: ib_request.mainSearchCriteriaCode)
                    .where(code_system_oid: ib_request.mainSearchCriteriaCodeSystem)
                    #.where("term ilike ?", "%#{ib_request.mainSearchCriteriaDisplayName}%")

      matches = initialize_matches(query.dup.to_a)

      # Conditionally add the other main search criteria portions of the query if they have
      # been specified
      #query2 = query.dup
      #query2 = query2.where("term ilike ?", "%#{ib_request.mainSearchCriteriaDisplayName}%") unless ib_request.mainSearchCriteriaDisplayName.blank?
      #puts query2.to_sql
      results = {}
      results[:mainSearchCriteriaDisplayName] = sub_query_terms(query, ib_request.mainSearchCriteriaDisplayName) unless ib_request.mainSearchCriteriaDisplayName.blank?
      puts results.inspect
    end
  end
end