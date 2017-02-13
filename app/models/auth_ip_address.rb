require 'ipv4_address_serializer'
require 'ipv6_address_serializer'

class AuthIpAddress < ApplicationRecord
  serialize :ipv4_address, IPv4AddressSerializer
  serialize :ipv6_address, IPv6AddressSerializer
  validate :ipv4_xor_ipv6?
  has_and_belongs_to_many :items

  def ipv4_xor_ipv6?
    if !ipv4_address ^ ipv6_address
      errors.add :base, 'You must include either an IPv4 Address or an IPv6 Address'
    end
  end

end
