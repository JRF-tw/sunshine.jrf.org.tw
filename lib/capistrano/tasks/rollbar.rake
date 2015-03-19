namespace :load do
  task :defaults do
    set :rollbar_token, ''
    set :rollbar_env, Proc.new { fetch :stage }
    set :rollbar_role, Proc.new { :app }
  end
end