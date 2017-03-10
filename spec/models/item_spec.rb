require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:item)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a handle' do
      expect(FactoryGirl.build(:item, handle: nil)).to_not be_valid
    end

    describe 'when creating products with identical handles' do
      let(:item) { FactoryGirl.build(:item, handle: 'identical') }

      before do
        FactoryGirl.create(:item, handle: 'identical')
      end

      it 'raises unique validation error' do
        expect(item).not_to be_valid
      end
    end
  end
end
