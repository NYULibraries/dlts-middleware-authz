class ApiKey < ApplicationRecord
  include BCrypt
  attr_accessor :full_api_key
  before_create :generate_api_key

  def self.generate!
    new_api_key = create!
    new_api_key.full_api_key
  end

  def api_key_private
    @api_key_private ||= Password.new(api_key_hash)
  end

  def api_key_private=(new_api_key_private)
    @api_key_private = Password.create(new_api_key_private)
    self.api_key_hash = @api_key_private
  end

  private
  def generate_api_key
    begin
      api_key_public = SecureRandom.base64.tr('+/=', 'Qrt')
      api_key_private = SecureRandom.base64.tr('+/=', 'Qrt')
      @full_api_key = api_key_public + api_key_private

      self.api_key_public = api_key_public
      self.api_key_private = api_key_private
    end while self.class.exists?(api_key_public: api_key_public)
  end
end
