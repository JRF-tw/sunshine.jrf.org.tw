Sidetiq.configure do |config|
  # Clock resolution in seconds (default: 1).
  # config.resolution = 0.5

  # Clock locking key expiration in ms (default: 1000).
  # config.lock_expire = 100

  # When `true` uses UTC instead of local times (default: false).
  config.utc = false

  # Scheduling handler pool size (default: number of CPUs as
  # determined by Celluloid).
  # config.handler_pool_size = 5

  # History stored for each worker (default: 50).
  # config.worker_history = 50
end
