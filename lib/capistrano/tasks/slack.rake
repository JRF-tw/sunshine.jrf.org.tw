namespace :load do
  task :defaults do
    set :slack_team,         -> { 'jrf-5fpro' }
    set :slack_webhook,      -> { 'https://hooks.slack.com/services/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' }
    set :slack_icon_url,     -> { 'https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2016-09-02/75648551252_215e9a0aac6d54c11e63_48.png' }
    set :slack_channel,      -> { '#deploy' }
    set :slack_username,     -> { 'deploy' }
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
