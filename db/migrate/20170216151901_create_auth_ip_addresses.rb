class CreateAuthIpAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_ip_addresses do |t|
      t.string :name
      t.integer :ipv4_address, limit: 8
      t.binary :ipv6_address, limit: 16

      t.timestamps
    end
  end
end
