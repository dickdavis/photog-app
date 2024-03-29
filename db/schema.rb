# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_03_051327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_packages", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.decimal "retainer_fee"
    t.decimal "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "booking_requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.date "requested_date"
    t.bigint "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "requested_time"
    t.index ["package_id"], name: "index_booking_requests_on_package_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "name"
    t.time "start_time"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_package_id"
    t.date "start_date"
    t.index ["booking_package_id"], name: "index_bookings_on_booking_package_id"
    t.index ["client_id"], name: "index_bookings_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email"
  end

  create_table "package_groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.decimal "retainer_fee"
    t.decimal "total_cost"
    t.text "description"
    t.bigint "package_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_group_id"], name: "index_packages_on_package_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "business_name", null: false
    t.string "brand", null: false
    t.text "bio"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "booking_requests", "packages"
  add_foreign_key "bookings", "booking_packages"
  add_foreign_key "bookings", "clients"
  add_foreign_key "packages", "package_groups"
end
