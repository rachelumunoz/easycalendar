class AddColumnsEventsRenameNameColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :name, :summary
    add_column :events, :description, :string
    add_column :events, :end, :datetime
    add_column :events, :location, :string
    add_column :events, :attendees, :string
  end
end
