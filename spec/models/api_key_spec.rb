require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:auth_service)).to be_valid
  end
end
