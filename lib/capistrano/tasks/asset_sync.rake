namespace :deploy do
  namespace :assets do
    task :sync do
      on roles(:assets_sync_server) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, 'assets:sync'
          end
        end
      end
    end
  end
end
after 'deploy:assets:precompile', 'deploy:assets:sync'
