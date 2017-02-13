class CreateJoinTableItemsAuthServices < ActiveRecord::Migration[5.0]
  def change
    create_join_table :items, :auth_services do |t|
      # t.index [:item_id, :auth_service_id]
      # t.index [:auth_service_id, :item_id]
    end
  end
end
