FactoryGirl.define do
  factory :item do
    handle { Faker::Internet.unique.password(17, 17) }
    end_service { (EndService.all.count > 0 ? EndService.all.sort_by{ rand }.first : FactoryGirl.create(:end_service)) }
    uri_fragment { "/#{Faker::Internet.unique.password(4, 8)}/#{Faker::StarWars.droid}/#{Faker::StarWars.planet}" }

    trait :auth_service do
      auth_services { [(AuthService.all.count > 0 ? AuthService.all.sort_by{ rand }.first : FactoryGirl.create(:auth_service))] }
    end

    trait :auth_ip_address do
      auth_ip_addresses { [(AuthIpAddress.all.count > 0 ? AuthIpAddress.all.sort_by{ rand }.first : FactoryGirl.create(:auth_ip_address, :ipv4))] }
    end
  end
end
