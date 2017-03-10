class CreateAuthServices < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_services do |t|
      t.string :name

      t.timestamps
    end
    add_index :auth_services, :name, unique: true
  end
end
