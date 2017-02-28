require 'rails_helper'

RSpec.describe AuthIpAddressGroup, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:auth_ip_address_group)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(FactoryGirl.build(:auth_ip_address_group, name: nil)).to_not be_valid
    end

    describe 'when creating products with identical names' do
      let(:auth_ip_address_group) { FactoryGirl.build(:auth_ip_address_group, name: 'identical') }

      before do
        FactoryGirl.create(:auth_ip_address_group, name: 'identical')
      end

      it 'raises unique validation error' do
        expect(auth_ip_address_group).not_to be_valid
      end
    end
  end
end
