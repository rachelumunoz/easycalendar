class AddColumnEventsGoogleEventId < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :google_event_id, :string
  end
end
