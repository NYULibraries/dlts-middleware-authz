class CreateAuthIpAddressGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_ip_address_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
