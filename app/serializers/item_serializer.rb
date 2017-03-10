class ItemSerializer < ActiveModel::Serializer
  attributes :id, :handle
  belongs_to :end_service
  has_many :auth_services
  has_many :auth_ip_addresses
end
