# role-based syntax
# ==================

role :app, %w{deployer@104.131.1.109 }
role :web, %w{deployer@104.131.1.109 }
role :db,  %w{deployer@104.131.1.109 }

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
  ['104.131.1.109'].each do |apps|
    server apps , user: 'deployer', roles: %w{ web app db }, primary: true
  end

set :application, 'predios_app'
set :branch, 'development'
set :rvm_type, :user
set :rails_env, "production"

# --------------
set :user, 'deployer'
set :rvm_ruby_version, '2.3.3'
set :deploy_to, "/home/deployer/apps/predios_app"
set :puma_user, 'deployer'
set :puma_jungle_conf, '/etc/puma.conf'
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 2
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, false
set :nginx_use_ssl, false

set :ssh_options, {
                    keys: %w(~/.ssh/id_rsa),
                    user: ENV["server_username"],
                    password: ENV["server_password"],
                    auth_methods: %w(publickey password)
                }