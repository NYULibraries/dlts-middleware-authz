FactoryGirl.define do
  factory :end_service do
    name { Faker::App.unique.name }
    uri { Faker::Internet.url }
  end
end
