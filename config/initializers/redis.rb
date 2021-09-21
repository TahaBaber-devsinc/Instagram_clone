$redis = Redis.new(url: ENV['REDIS_PROVIDER']) if ENV['REDIS_PROVIDER']
