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

ActiveRecord::Schema[7.0].define(version: 2024_08_19_073929) do
  create_table "forecasts", force: :cascade do |t|
    t.string "zipcode"
    t.datetime "sunrise"
    t.datetime "sunset"
    t.decimal "temp"
    t.decimal "feels_like"
    t.integer "pressure"
    t.integer "humidity"
    t.decimal "dew_point"
    t.decimal "uvi"
    t.integer "clouds"
    t.integer "visibility"
    t.decimal "wind_speed"
    t.integer "wind_deg"
    t.decimal "wind_gust"
    t.string "main_descriptor"
    t.string "description"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
