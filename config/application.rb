require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JrfSunny
  class Application < Rails::Application
    config.action_mailer.delivery_method = :amazon_ses

    # disable some file generators
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.helper = false
    config.generators.helper_specs = false
    # factory girl rails
    config.generators do |g|
      g.test_framework :rspec, fixture: true, views: false, fixture_replacement: :factory_girl
      g.factory_girl dir: "spec/factories"
    end

    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :delete, :put]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Taipei'
    config.autoload_paths += %W(#{config.root}/app)
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = "zh-TW"
    config.i18n.fallbacks = [:en]

    PRECOMPILE_FILES = ['priority.js']
    # Make public assets requireable in manifest files
    # config.assets.paths << Rails.root.join("public", "assets", "stylesheets")
    # config.assets.paths << Rails.root.join("public", "assets", "javascripts")

    Time::DATE_FORMATS.merge!(default: "%Y-%m-%d %H:%M", year: "%Y", date: "%m/%d")
  end
end
