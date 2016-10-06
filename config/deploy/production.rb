set :stage, :production

set :user, "deploy"
set :app_host,    "vfsmstattag.fsm.northwestern.edu"
set :app_server,  "docubuild@#{ fetch(:app_host) }"
set :ssl_cert_file_base, "#{fetch(:application)}"
set :ssl_cert_chain_file_base, "#{fetch(:application)}"
set :ssl_cert_key_file_base, "#{fetch(:application)}"
set :site_name_alias, "#{fetch(:application)}"

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
