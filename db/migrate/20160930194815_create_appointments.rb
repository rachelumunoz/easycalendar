class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :coach_activity_id
      t.integer :child_id
      t.integer :location_id
      t.datetime :start
      t.datetime :end
      t.string :color

      t.timestamps
    end
  end
end
