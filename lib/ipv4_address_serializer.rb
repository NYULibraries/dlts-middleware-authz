class IPv4AddressSerializer
  def self.load(value)
    IPAddr.new(value, Socket::AF_INET).to_s if value
  end

  def self.dump(value)
    IPAddr.new(value).to_i
  end
end
