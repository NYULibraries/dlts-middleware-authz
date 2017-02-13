FactoryGirl.define do
  factory :auth_ip_address do
    name { Faker::StarWars.droid }

    trait :ipv4 do
      ipv4_address { Faker::Internet.ip_v4_address }
    end

    trait :ipv6 do
      ipv6_address { Faker::Internet.ip_v6_address }
    end
  end
end
