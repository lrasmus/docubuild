# config valid only for current version of Capistrano
lock '3.9.1'

set :application, 'docubuild'
set :repo_url, 'ssh://git@stash.nubic.northwestern.edu:7999/emerge/docubuild.git'
set :branch, 'develop'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/var/www/apps/#{ fetch(:application) }_#{ fetch(:stage) }"

# Default value for :scm is :git
set :scm, :git unless fetch(:stage) == 'vm'

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :rvm_type, :system
set :rvm_ruby_version, '2.3.1'

set :base_uri, '/'

# Default alias we use will use the stage
set :site_name_alias, "docubuild-#{ fetch(:stage) }"

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle tmp/import}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :httpd_graceful do
    on roles(:web), in: :sequence, wait: 5 do
      execute :sudo, "service httpd restart"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :deploy_prepare do
  desc 'Configure virtual host'
  task :create_vhost do
    on roles(:web), in: :sequence, wait: 5 do
      vhost_config = <<-EOF
NameVirtualHost *:80
NameVirtualHost *:443

<VirtualHost *:80>
  ServerName #{ fetch(:site_name_alias) }.fsm.northwestern.edu
  ServerAlias #{ fetch(:site_name_alias) }.fsm.northwestern.edu
  Redirect permanent / https://#{ fetch(:site_name_alias) }.fsm.northwestern.edu/
</VirtualHost>

<VirtualHost *:443>
  PassengerFriendlyErrorPages off
  PassengerAppEnv #{ fetch(:stage) }
  PassengerRuby /usr/local/rvm/wrappers/ruby-#{ fetch(:rvm_ruby_version) }/ruby

  ServerName #{ fetch(:site_name_alias) }.fsm.northwestern.edu
  ServerAlias #{ fetch(:site_name_alias) }.fsm.northwestern.edu

  SSLEngine On
  SSLCertificateFile /etc/pki/tls/certs/#{ fetch(:ssl_cert_file_base) }_fsm_northwestern_edu_cert.cer
  SSLCertificateChainFile /etc/pki/tls/certs/#{ fetch(:ssl_cert_chain_file_base) }_fsm_northwestern_edu_interm.cer
  SSLCertificateKeyFile /etc/pki/tls/private/#{ fetch(:ssl_cert_key_file_base) }_fsm_northwestern_edu.key

  TraceEnable off

  DocumentRoot #{ fetch(:deploy_to) }/current/public
  PassengerBaseURI /
  PassengerDebugLogFile /var/log/httpd/#{ fetch(:application) }_#{ fetch(:stage) }_passenger.log

  <Directory #{ fetch(:deploy_to) }/current/public >
    Allow from all
    Options -MultiViews
  </Directory>
</VirtualHost>

EOF
      execute :echo, "\"#{ vhost_config }\"", ">", "/etc/httpd/conf.d/#{ fetch(:application) }_#{ fetch(:stage) }.conf"
    end
  end
end

after "deploy:updated", "deploy:cleanup"
if fetch(:stage) == :vm
  after "deploy:finished", "deploy:restart"
else
  after "deploy:finished", "deploy_prepare:create_vhost"
  after "deploy_prepare:create_vhost", "deploy:httpd_graceful"
  after "deploy:httpd_graceful", "deploy:restart"
end
