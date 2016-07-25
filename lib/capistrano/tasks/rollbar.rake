namespace :load do
  task :defaults do
    set :rollbar_token, "758daa0b26bd4f589ca484d5e1b1d9b3"
    set :rollbar_env, proc { fetch :stage }
    set :rollbar_role, proc { :db }
  end
end
