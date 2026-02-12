class CreateLaps < ActiveRecord::Migration[8.1]
  def change
    create_table :laps do |t|
      t.references :race_participant, null: false, foreign_key: true
      t.integer :lap_number, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :lap_time, null: false

      t.timestamps
    end

    add_index :laps, [ :race_participant_id, :lap_number ], unique: true
  end
end
