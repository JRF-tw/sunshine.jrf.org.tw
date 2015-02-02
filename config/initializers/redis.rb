def connect_to_redis!
  Redis.current = Redis.new(Setting.redis)
  Redis.current.client.reconnect
end

connect_to_redis!

begin
  Redis.current.ping
rescue
  puts "warring: No redis server! Please install and start redis, install on MacOSX: 'sudo brew install redis', start : 'redis-server'"
end

# for Passenger
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    connect_to_redis! if forked
  end
end