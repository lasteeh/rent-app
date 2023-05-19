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

ActiveRecord::Schema[7.0].define(version: 2023_05_18_054724) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "landlords", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password", null: false
    t.string "token"
    t.index ["token"], name: "index_landlords_on_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.string "address", null: false
    t.string "city", null: false
    t.string "province", null: false
    t.string "zip_code", null: false
    t.integer "units"
    t.uuid "landlord_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["landlord_id"], name: "index_properties_on_landlord_id"
  end

  create_table "rentals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "start_date", null: false
    t.integer "duration_months", default: 1, null: false
    t.uuid "renter_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_rentals_on_property_id"
    t.index ["renter_id"], name: "index_rentals_on_renter_id"
  end

  create_table "renters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password", null: false
    t.string "token"
    t.index ["token"], name: "index_renters_on_token", unique: true
  end

  add_foreign_key "properties", "landlords"
  add_foreign_key "rentals", "properties"
  add_foreign_key "rentals", "renters"
end
