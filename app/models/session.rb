class Session < ApplicationRecord
  validates_uniqueness_of :token
  before_create :generate_token
  before_create :set_expiry
  scope :alive, -> { where alive? }
  scope :expired, -> { where expired? }

  def active?(providers = {})
    return true unless self.expires_at
    return false unless self.expires_at > Time.now.utc
    return true if providers.empty?
    providers.any? { |provider| self.data['provider'] == provider }
  end

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Session.exists?(token: random_token)
    end
  end

  def set_expiry
    self.expires_at = 2.hours.from_now
  end

  private
  def self.alive?
    self.arel_attribute(:expires_at).gt(Time.now)
  end

  def self.expired?
    self.arel_attribute(:expires_at).lteq(Time.now)
  end
end
