def connect_to_redis
  Redis.current = Redis.new(Setting.redis)
end

connect_to_redis

begin
  Redis.current.ping
rescue
  puts "warring: No redis server! Please install and start redis, install on MacOSX: 'sudo brew install redis', start : 'redis-server /usr/local/etc/redis.conf'"
end
