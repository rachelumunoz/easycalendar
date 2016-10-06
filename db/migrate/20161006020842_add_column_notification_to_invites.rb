class AddColumnNotificationToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :notification, :boolean, :default => true
  end
end
