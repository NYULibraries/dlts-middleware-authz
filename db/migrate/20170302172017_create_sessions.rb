class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :token
      t.json :oauth_response
      t.datetime :expires_at

      t.timestamps
    end
    add_index :sessions, :token, unique: true
  end
end
