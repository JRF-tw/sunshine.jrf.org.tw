namespace :load do
  task :defaults do
    set :slack_team,         -> { 'your_team_name' }
    set :slack_webhook,      -> { '12341234' }
    set :slack_icon_url,     -> { 'https://slack-assets2.s3-us-west-2.amazonaws.com/5504/img/emoji/1f680.png' }
    set :slack_channel,      -> { '#general' }
    set :slack_username,     -> { 'myapp' }
    set :slack_run_starting, -> { true }
    set :slack_run_finished, -> { true }
    set :slack_run_failed,   -> { true }
    set :slack_msg_starting, -> { "#{ENV['USER'] || ENV['USERNAME']} has started deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}." }
    set :slack_msg_finished, -> { "#{ENV['USER'] || ENV['USERNAME']} has finished deploying branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}." }
    set :slack_msg_failed,   -> { "*ERROR!* #{ENV['USER'] || ENV['USERNAME']} failed to deploy branch #{fetch :branch} of #{fetch :application} to #{fetch :rails_env, 'production'}." }
    # set :slack_via_slackbot, ->{ false }
    # set :slack_token,        ->{ '' }
  end
end
