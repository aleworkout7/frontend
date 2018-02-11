SSHKit.config.command_map[:rake] = "bundle exec rake"

lock '3.6.1'
set :rvm_roles, [:app, :web]

set :repo_url, 'git@bitbucket.org:rprada/predios_app.git'
set :deploy_to, "/home/deployer/apps/predios_app"
set :git_shallow_clone, 1
set :scm, :git
set :use_sudo, true
set :stage, [:production]
set :deploy_via, :copy
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}
set :keep_releases, 5
set :rails_env, "production"
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set(:config_files, %w(
  nginx.conf
  log_rotation
  unicorn_init.sh
  database.yml
))


#nginx
set :nginx_location, "/etc/nginx"

#set simlinks
namespace :app do
  task :update_rvm_key do
    execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
  end
end

# namespace :figaro do
#   desc "SCP transfer figaro configuration to the shared folder"
#   task :setup do
#     transfer :up, "config/application.yml", "#{shared_path}/application.yml", :via => :scp
#   end

#   desc "Symlink application.yml to the release path"
#   task :finalize do
#     run "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
#   end
# end


#before "rvm1:install:rvm", "app:update_rvm_key"

namespace :deploy do
  # check that all the local changes are pushed to the remote develop branch
  # before :deploy, "deploy:git_sync"

  # restart nginx
  after :deploy, "deploy:restart"

  #  before :deploy, "deploy:check_revision"
  #  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  desc 'Runs rake db:seed'
  task :seed do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :sudo, "./restart.sh"
      execute :touch, release_path.join('tmp/restart.txt')
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