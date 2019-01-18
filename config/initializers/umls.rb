Rails.application.configure do
  config.x.umls.umls_auth_base_url = 'https://utslogin.nlm.nih.gov/cas/v1/tickets'
  config.x.umls.umls_rest_base_url = 'https://uts-ws.nlm.nih.gov/rest'
  config.x.umls.umls_service = 'http://umlsks.nlm.nih.gov'
end