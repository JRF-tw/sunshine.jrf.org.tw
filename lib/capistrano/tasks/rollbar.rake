namespace :load do
  task :defaults do
    set :rollbar_token, 'c6ffee4f330945a68faca168304c83a8'
    set :rollbar_env, proc { fetch :stage }
    set :rollbar_role, proc { :db }
  end
end
