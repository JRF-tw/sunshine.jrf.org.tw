Rails.application.configure do
	# Add Rack::LiveReload to the bottom of the middleware stack with the default options:
	# config.middleware.insert_after ActionDispatch::Static, Rack::LiveReload

	# or, if you're using better_errors:
	config.middleware.insert_before Rack::Lock, Rack::LiveReload

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Disables appending md5 hashes for caching with future expire headers.
  # BrowserSync can reference and replace them properly as they get changed.
  config.assets.digest = false
  config.assets.precompile += JrfSunny::Application::PRECOMPILE_FILES

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  config.active_record.raise_in_transactional_callbacks = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.cache_store = :dalli_store, *(Setting.dalli.servers + [ Setting.dalli.options.symbolize_keys ])

  config.action_controller.asset_host = ->(source){ Setting.assets_host }
end
