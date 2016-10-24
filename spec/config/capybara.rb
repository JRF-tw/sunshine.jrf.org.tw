require 'capybara/rails'
require 'capybara/email/rspec'

Capybara.current_driver = :webkit
Capybara.javascript_driver = :webkit
Capybara.server_port = '8000'
Capybara.app_host = "http://#{Setting.host}:#{Capybara.server_port}"
ActionMailer::Base.default_url_options = { host: Setting.host, port: 8000 }

Capybara::Webkit.configure(&:allow_unknown_urls)

RSpec.configure do |config|
  config.include Capybara::CommonHelper, type: :feature
  config.include Capybara::LawyerHelper, type: :feature
  config.include Capybara::ObserverHelper, type: :feature
  config.include Capybara::PartyHelper, type: :feature
end
