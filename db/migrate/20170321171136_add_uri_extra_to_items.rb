class AddUriExtraToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :uri_extra, :string
  end
end
