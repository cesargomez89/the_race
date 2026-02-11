class CreateRaceParticipants < ActiveRecord::Migration[8.1]
  def change
    create_table :race_participants do |t|
      t.references :race, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
