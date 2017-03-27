class RemoveTokenFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :token, :string, limit: 45
  end
end
