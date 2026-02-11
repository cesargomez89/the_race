class CreateRaces < ActiveRecord::Migration[8.1]
  def change
    create_table :races do |t|
      t.string :name, null: false
      t.string :track_name, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.decimal :start_latitude, precision: 9, scale: 6, null: false
      t.decimal :start_longitude, precision: 9, scale: 6, null: false
      t.decimal :finish_latitude, precision: 9, scale: 6, null: false
      t.decimal :finish_longitude, precision: 9, scale: 6, null: false

      t.timestamps
    end
  end
end
