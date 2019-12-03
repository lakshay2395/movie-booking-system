# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_03_230207) do

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "show_id", null: false
    t.integer "seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["show_id"], name: "index_bookings_on_show_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "halls", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "seats"
    t.integer "theatre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theatre_id"], name: "index_halls_on_theatre_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "director_name"
    t.date "release_date"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_regions_on_parent_id"
  end

  create_table "shows", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "hall_id", null: false
    t.date "show_date"
    t.integer "timing_id", null: false
    t.float "seat_price"
    t.integer "available_seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hall_id"], name: "index_shows_on_hall_id"
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["timing_id"], name: "index_shows_on_timing_id"
  end

  create_table "theatres", force: :cascade do |t|
    t.string "name"
    t.integer "region_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_theatres_on_region_id"
  end

  create_table "timings", force: :cascade do |t|
    t.string "name"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_id"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bookings", "shows"
  add_foreign_key "bookings", "users"
  add_foreign_key "halls", "theatres"
  add_foreign_key "regions", "regions", column: "parent_id"
  add_foreign_key "shows", "halls"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "timings"
  add_foreign_key "theatres", "regions"


  add_index :shows, [:hall_id, :movie_id, :timing_id], unique: true
  add_index :users, [:email_id], unique: true
end
