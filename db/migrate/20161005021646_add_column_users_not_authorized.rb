class AddColumnUsersNotAuthorized < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :not_authorized, :boolean
    add_column :users, :authorization_url, :string
  end
end
