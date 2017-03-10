class CreateJoinTableItemsAuthIpAddresses < ActiveRecord::Migration[5.0]
  def change
    create_join_table :items, :auth_ip_addresses do |t|
      # t.index [:item_id, :auth_ip_address_id]
      # t.index [:auth_ip_address_id, :item_id]
    end
  end
end
