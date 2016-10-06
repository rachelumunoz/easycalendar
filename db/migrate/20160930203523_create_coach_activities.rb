class CreateCoachActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :coach_activities do |t|
      t.integer :coach_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :coach_activities, [:coach_id, :activity_id], unique: true
  end
end
