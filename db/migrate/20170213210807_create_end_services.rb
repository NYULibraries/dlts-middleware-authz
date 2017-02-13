class CreateEndServices < ActiveRecord::Migration[5.0]
  def change
    create_table :end_services do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
    add_index :end_services, :name, unique: true
    add_index :end_services, :uri, unique: true
  end
end
