require 'rails_helper'

RSpec.describe AuthIpAddress, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:auth_ip_address, :ipv4)).to be_valid
    expect(FactoryGirl.create(:auth_ip_address, :ipv6)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without with both ipv6 and ipv4' do
      expect(FactoryGirl.build(:auth_ip_address,
                               ipv4_address: Faker::Internet.ip_v4_address,
                               ipv6_address: Faker::Internet.ip_v6_address)).to_not be_valid
    end
  end
end
