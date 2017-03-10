class AuthIpAddressGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :auth_ip_addresses
end
