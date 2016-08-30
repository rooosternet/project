#config/initializers/redis.rb
# require 'redis'
# require 'redis/objects'

# REDIS_CONFIG = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
# dflt = REDIS_CONFIG[:default].symbolize_keys
# cnfg = dflt.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]
# REDIS_CONFIG = YAML.load(File.open("#{Rails.root}/config/redis.yml")).with_indifferent_access[Rails.env].merge(:thread_safe => true)
# puts REDIS_CONFIG
# $redis = Redis.new(REDIS_CONFIG)
# Redis::Objects.redis = $redis
#$redis_ns = Redis::Namespace.new(cnfg[:namespace], :redis => $redis) if cnfg[:namespace]

# To clear out the db before each test
# $redis.flushdb if Rails.env = "test"

REDIS_CONFIG = YAML.load(File.open("#{Rails.root}/config/redis.yml")).with_indifferent_access[Rails.env].merge(:thread_safe => true)
puts "REDIS_CONFIG: #{REDIS_CONFIG}"
require 'redis'
require 'redis/objects'

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      $redis.client.disconnect
      $redis = Redis.new(REDIS_CONFIG)
      # $redis = Redis.new(:host => 'localhost', :port => YAML.load(File.open("#{rails_root}/config/redis.yml")).with_indifferent_access[rails_env][:port])
      Rails.logger.info "Reconnecting to redis"
    else
      # We're in conservative spawning mode. We don't need to do anything.
    end
  end
end

unless defined?($redis)

  begin 
    print "Connecting to Redis...\n" 
    $redis = Redis.new(REDIS_CONFIG)
    $redis.ping
    Redis::Objects.redis = $redis
    print "Redis connection established...\n" 
  rescue Redis::CannotConnectError => e
    print "Error: Redis server unavailable...." 
    puts e.message
    puts e.backtrace
    $redis = nil
  end 

# Redis::Objects.redis = Redis.new(REDIS_CONFIG)
# require 'rails_feature_management'    
# Rails.feature_manager.engine = $redis
#Rails.feature_manager.safe_mode!
end

