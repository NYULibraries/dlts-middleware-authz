class CreateJoinTableAuthIpAddressGroup < ActiveRecord::Migration[5.0]
  def change
    create_join_table :auth_ip_address_groups, :auth_ip_addresses do |t|
      # t.index [:auth_ip_address_group_id, :auth_ip_address_id]
      # t.index [:auth_ip_address_id, :auth_ip_address_group_id]
    end
  end
end
