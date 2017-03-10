class Item < ApplicationRecord
  validates_presence_of :handle
  validates_uniqueness_of :handle

  has_and_belongs_to_many :auth_ip_addresses
  has_and_belongs_to_many :auth_services
  belongs_to :end_service
end
