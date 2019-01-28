require 'singleton'
require 'json'
require 'rest-client'

class UmlsRestClient
  include Singleton

  MIN_SEARCH_LENGTH = 2
  SEARCH_PATH = "/search/current"
  DESCENDANT_PATH = "/content/current/source/"
  SEARCH_CODE_PATH = "/crosswalk/current/source"
  SEARCH_PARAMETER = "string"
  SEARCH_TYPE_PARAMETER = "searchType"
  SEARCH_TYPE = "rightTruncation"
  RETURN_TYPE_PARAMETER = "returnIdType"
  RETURN_TYPE = "code"
  CS_PARAMETER = "sabs"
  PAGE_SIZE_PARAMETER = "pageSize"
  PAGE_SIZE_VALUE = "100"
  TICKET_PARAMETER = "ticket"

  def initialize
    clear_ticket_state
  end

  def search_by_name search, vocab
    if search.length < MIN_SEARCH_LENGTH
      return nil
    end

    params = {
      SEARCH_PARAMETER => search,
      PAGE_SIZE_PARAMETER => PAGE_SIZE_VALUE,
      CS_PARAMETER => vocab,
      SEARCH_TYPE_PARAMETER => SEARCH_TYPE,
      RETURN_TYPE_PARAMETER => RETURN_TYPE,
      TICKET_PARAMETER => get_service_ticket
    }
    response = RestClient.get("#{Rails.configuration.x.umls.umls_rest_base_url}#{SEARCH_PATH}?#{params.to_query}")
    data = JSON.parse(response.body)
    return [] if data.nil? or data["result"].nil? or data["result"]["results"].nil?

    results = data["result"]["results"]
    results
  end

  private

  # Helper method to reset all local members that hold state about our tickets
  def clear_ticket_state
    @last_updated = nil
    @ticket_granting_ticket = nil
  end

  # Generate the ticket-tranting ticket (TGT)
  # https://documentation.uts.nlm.nih.gov/rest/authentication.html
  def get_ticket_granting_ticket
    if tgt_expired?
      # It's expired, so we're going to start this process by resetting the state
      clear_ticket_state

      response = RestClient.post(Rails.configuration.x.umls.umls_auth_base_url, { username: Rails.configuration.x.umls.username, password: Rails.configuration.x.umls.password })
      if response.code != 201 # expect a 201/Created response
        return nil
      end

      # The actual ticket response is a URL that we pull from the location.  The body has an HTML form,
      # which we don't want to have to parse.
      @ticket_granting_ticket = response.headers[:location]
      @last_updated = Time.now.to_i
    end

    @ticket_granting_ticket
  end

  # Generate a service ticket (one-time use)
  def get_service_ticket
    tgt = get_ticket_granting_ticket
    return nil if tgt.blank?

    puts tgt
    puts Rails.configuration.x.umls.umls_service
    response = RestClient.post(tgt, { service: Rails.configuration.x.umls.umls_service })
    if response.code != 200 # expect a 200/OK response
      return nil
    end

    response.body
  end

  # Determine if a ticket-granting ticket has expired or not.  If the TGT has never
  # been set, we consider that expired as well.
  def tgt_expired?
    return true if @last_updated.nil? or @ticket_granting_ticket.nil?
    (@last_updated + 5) < Time.now.to_i  # TGTs have an 8 hour life
  end
end