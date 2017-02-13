require 'rails_helper'

RSpec.describe AuthService, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:auth_service)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(FactoryGirl.build(:auth_service, name: nil)).to_not be_valid
    end

    describe 'when creating products with identical names' do
      let(:auth_service) { FactoryGirl.build(:auth_service, name: 'identical') }

      before do
        FactoryGirl.create(:auth_service, name: 'identical')
      end

      it 'raises unique validation error' do
        expect(auth_service).not_to be_valid
      end
    end
  end
end
