source 'https://rubygems.org'
gem 'rails', '4.2.5.1'

# DB
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'redis'
gem 'redis-objects', require: "redis/objects"
gem 'redis-namespace'

# stores
gem 'dalli'
gem 'connection_pool'

# ENV
gem 'settingslogic'

# view rendering
gem 'jbuilder', '~> 2.0'
gem 'simple_form'
gem 'nested_form'
gem 'slim'

# assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'asset_sync'
gem 'chosen-rails', "~> 1.2.0"
gem "select2-rails"

# background jobs
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidekiq-limit_fetch'
gem 'whenever'

# file upload
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'carrierwave_backgrounder'

# editor
gem 'redactor-rails'

# api
gem 'rabl-rails'

# xls Download
gem 'axlsx', '~> 2.0'
gem "axlsx_rails"

# soft delete
# gem 'paranoia'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development do
  # capistrano
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  # unicorn
  gem 'capistrano3-unicorn'
  # slack
  gem 'slackistrano', require: false

  gem 'guard-annotate'
  gem 'annotate'
  gem 'awesome_print'
  gem 'xray-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'http_logger'
  gem 'spring'
  gem 'venus', git: "git@github.com:marsz/venus.git", branch: 'v1.0'
  gem 'rename'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug'
  gem 'rubocop', require: false
end

group :test do
  gem 'webmock'
  gem 'test_after_commit'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

gem 'kaminari'

# devise
gem 'devise'
gem 'devise-async'

# aws
gem 'aws-sdk-v1'
gem 'aws-sdk'

# unicorn
gem 'unicorn'

# system mionitor
gem 'rollbar'
gem 'newrelic_rpm'

# front-end
gem 'jquery-ui-rails'
gem 'bootstrap-sass', '~> 2.3'

# SEO
gem 'crummy'
gem 'meta-tags', require: 'meta_tags'
gem 'sitemap_generator'

# internal search
gem 'ransack'

gem 'smarter_csv', '~> 1.1'
gem 'mechanize'
gem 'iconv'
gem 'slack-notifier'

# SMS
gem 'twilio-ruby'
