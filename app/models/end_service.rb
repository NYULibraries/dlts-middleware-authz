class EndService < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :uri
  validates_uniqueness_of :uri

  has_many :items
end
