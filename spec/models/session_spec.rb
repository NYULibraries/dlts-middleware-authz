require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:session)).to be_valid
  end
end
