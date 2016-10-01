class AddTokenUidProviderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
