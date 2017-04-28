FactoryGirl.define do
  factory :auth_service do
    name { Faker::App.unique.name }
    provider { :facebook }
  end
end
