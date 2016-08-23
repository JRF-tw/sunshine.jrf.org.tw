require "database_cleaner"

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    # Clean all tables to start
    DatabaseCleaner.clean_with :deletion
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
  end

  config.after(:each) do
    # Rollback transaction
    DatabaseCleaner.clean
  end
end
