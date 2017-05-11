# more config options:
#   https://github.com/seuros/capistrano-sidekiq/blob/master/lib/capistrano/tasks/sidekiq.cap

namespace :load do
  task :defaults do
    set :sidekiq_role, [:sidekiq_server, :crawler]
  end
end

after 'bundler:install', 'sidekiq:upload_crawler_config'
namespace :sidekiq do
  task :upload_crawler_config do
    on roles(:crawler) do
      upload!('./config/crawler_sidekiq.yml', "#{release_path}/config/sidekiq.yml")
    end
  end
end
