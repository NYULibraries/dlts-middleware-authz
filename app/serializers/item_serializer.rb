class ItemSerializer < ActiveModel::Serializer
  attributes :id, :handle, :token
  belongs_to :end_service
  has_many :auth_services
  has_many :auth_ip_addresses
end
