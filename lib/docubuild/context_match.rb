module DocUBuild
  class ContextMatch
    # Allowed values for the match_type field
    NoMatch = 0, DirectMatch = 1, InheritedMatch = 2

    attr_accessor :item, :match_type

    # item - the item that matches a context (Document or Section)
    # match_type - what type of match was made (see values above)
    def initialize item, match_type
      @item = item
      @match_type = match_type
    end
  end
end