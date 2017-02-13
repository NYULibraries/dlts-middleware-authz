FactoryGirl.define do
  factory :auth_service do
    name { Faker::App.unique.name }
  end
end
