set :stage, :vm

set :rvm_type, :auto
set :deploy_to, '/home/deploy/docubuild'

server '172.16.51.236', user: 'deploy', roles: %w{web app db}
