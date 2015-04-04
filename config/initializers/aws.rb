# aws ses: https://github.com/aws/aws-sdk-ruby/
AWS.config(Setting.aws)
ActionMailer::Base.default_url_options = { host: Setting.host }
# ActionMailer::Base.asset_host = "http://#{Setting.carrierwave.host}"