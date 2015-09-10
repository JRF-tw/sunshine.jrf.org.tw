# config valid only for current version of Capistrano
lock '3.4.0'

# 指定使用 nvm 的 bash 指令，防止 capistrano 回去找 usr/bin/env
nvm_sh       = '. /home/apps/.nvm/nvm.sh'

set :application, 'jrf-sunny'
set :repo_url, 'git@github.com:5fpro/jrf-sunny.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
    # invoke 'unicorn:restart'

    # passenger
    # execute :mkdir, '-p', release_path.join('tmp')
    # execute :touch, release_path.join('tmp/restart.txt')
  end

  desc "Run bower install"
  task :bower_install do
    invoke "cd #{release_path} && bower install"
  end

  desc "Run npm install"
  task :npm_install do
    invoke "cd #{release_path} && npm install && RAILS_ENV='production' gulp build"
  end

end

# Compile assets with Gulp before assets pipeline
before "deploy:assets:precompile", "deploy:gulp_build"
namespace :deploy do
  desc "Build public assets"
  task :gulp_build => [:deploy, :npm_install] do
    on roles(:web) do
      execute "bash -c '#{nvm_sh} && cd #{release_path} && gulp build'"
    end
  end

  desc "Run npm install"
  task :npm_install => [:deploy, :bower_install] do
    on roles(:web) do
      execute "bash -c '#{nvm_sh} && cd #{release_path} && npm install'"
    end
  end

  desc "Run bower install"
  task :bower_install do
    on roles(:web) do
      execute "bash -c '#{nvm_sh} && cd #{release_path} && bower install'"
    end
  end
end


# uncomment while first deploy
# before "deploy:migrate", "deploy:db_create"
# namespace :deploy do
#   task :db_create do
#     on primary fetch(:migration_role) do
#       within release_path do
#         with rails_env: fetch(:rails_env) do
#           execute :rake, "db:create"
#         end
#       end
#     end
#   end
# end

set :rollbar_token, '758daa0b26bd4f589ca484d5e1b1d9b3'
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :db }
