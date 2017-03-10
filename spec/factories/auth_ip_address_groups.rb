FactoryGirl.define do
  factory :auth_ip_address_group do
    name { Faker::App.unique.name }
    auth_ip_addresses { FactoryGirl.create_list(:auth_ip_address, 10, [:ipv4, :ipv6].sample) }
  end
end
