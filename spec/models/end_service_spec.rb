require 'rails_helper'

RSpec.describe EndService, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:end_service)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(FactoryGirl.build(:end_service, name: nil)).to_not be_valid
    end

    describe 'when creating products with identical names' do
      let(:end_service) { FactoryGirl.build(:end_service, name: 'identical') }

      before do
        FactoryGirl.create(:end_service, name: 'identical')
      end

      it 'raises unique validation error' do
        expect(end_service).not_to be_valid
      end
    end
  end
end
