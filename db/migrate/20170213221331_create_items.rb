class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :handle, limit: 17
      t.string :token, limit: 45
      t.references :end_service, foreign_key: true

      t.timestamps
    end
    add_index :items, :handle, unique: true
    add_index :items, :token, unique: true
  end
end
