class AddProviderToAuthService < ActiveRecord::Migration[5.0]
  def change
    add_column :auth_services, :provider, :string
  end
end
