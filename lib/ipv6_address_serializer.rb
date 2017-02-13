class IPv6AddressSerializer
  def self.load(value)
    IPAddr.new_ntoh(value).to_s if value
  end

  def self.dump(value)
    IPAddr.new(value).hton
  end
end
