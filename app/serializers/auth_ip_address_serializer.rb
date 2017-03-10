class AuthIpAddressSerializer < ActiveModel::Serializer
  attributes :id, :name, :version, :ip_address
  has_many :auth_ip_address_groups

  def version
    return 'ipv4' if object.ipv4_address
    'ipv6'
  end

  def ip_address
    object.ipv4_address || object.ipv6_address
  end
end
