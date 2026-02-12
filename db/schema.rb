# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_11_164113) do
  create_table "cars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "driver_name"
    t.integer "number"
    t.string "team"
    t.datetime "updated_at", null: false
  end

  create_table "laps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "end_time", null: false
    t.integer "lap_number", null: false
    t.integer "lap_time", null: false
    t.integer "race_participant_id", null: false
    t.datetime "start_time", null: false
    t.datetime "updated_at", null: false
    t.index ["race_participant_id", "lap_number"], name: "index_laps_on_race_participant_id_and_lap_number", unique: true
    t.index ["race_participant_id"], name: "index_laps_on_race_participant_id"
  end

  create_table "race_participants", force: :cascade do |t|
    t.integer "car_id", null: false
    t.datetime "created_at", null: false
    t.integer "race_id", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_race_participants_on_car_id"
    t.index ["race_id"], name: "index_race_participants_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "end_time", null: false
    t.decimal "finish_latitude", precision: 9, scale: 6, null: false
    t.decimal "finish_longitude", precision: 9, scale: 6, null: false
    t.string "name", null: false
    t.decimal "start_latitude", precision: 9, scale: 6, null: false
    t.decimal "start_longitude", precision: 9, scale: 6, null: false
    t.datetime "start_time", null: false
    t.string "track_name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_races_on_name", unique: true
  end

  add_foreign_key "laps", "race_participants"
  add_foreign_key "race_participants", "cars"
  add_foreign_key "race_participants", "races"
end
