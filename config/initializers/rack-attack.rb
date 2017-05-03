class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.throttle('req/ip', :limit => 15, :period => 5.seconds) do |req|
    '127.0.0.1' != req.ip && '::1' != req.ip
  end
end
