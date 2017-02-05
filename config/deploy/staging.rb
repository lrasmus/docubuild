set :stage, :staging

set :user, "deploy"
set :app_host,    "vtfsmstattag.fsm.northwestern.edu"
set :app_server,  "docubuild@#{ fetch(:app_host) }"
set :ssl_cert_file_base, "#{ fetch(:site_name_alias) }"
set :ssl_cert_chain_file_base, "#{ fetch(:site_name_alias) }"
set :ssl_cert_key_file_base, "#{ fetch(:application) }_#{ fetch(:stage) }"

server "#{ fetch(:app_host) }",
  user: "#{ fetch(:user) }",
  port: 22,
  roles: %w{web app},
  ssh_options: {
      user: "#{ fetch(:user) }",
      keys: "%w(/home/#{ fetch(:user) }/.ssh/id_rsa)",
      forward_agent: true,
      auth_methods: %w(publickey password)
  }
