class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :api_key_public
      t.string :api_key_hash
      t.timestamps
    end
  end
end
