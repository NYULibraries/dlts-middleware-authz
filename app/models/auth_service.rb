class AuthService < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :items
end
