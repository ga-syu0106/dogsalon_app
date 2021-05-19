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

ActiveRecord::Schema.define(version: 2021_05_18_130507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "booking_menus", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_booking_menus_on_booking_id"
    t.index ["menu_id"], name: "index_booking_menus_on_menu_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_date_time", null: false
    t.datetime "end_date_time", null: false
    t.text "booking_shop_comment"
    t.bigint "customer_id", null: false
    t.bigint "pet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_last_booking"
    t.datetime "end_last_booking"
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["pet_id"], name: "index_bookings_on_pet_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name"
    t.string "furigana_last_name"
    t.string "furigana_first_name"
    t.string "postcode"
    t.string "address", null: false
    t.string "homephone"
    t.string "mobilephone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enquetes", force: :cascade do |t|
    t.integer "know_shop"
    t.string "know_shop_comment"
    t.bigint "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_enquetes_on_customer_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "menu_name", null: false
    t.integer "breed", null: false
    t.integer "price", null: false
    t.time "working_hours", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "pet_name", null: false
    t.integer "breed", null: false
    t.datetime "birthday"
    t.integer "gender"
    t.text "pet_comment"
    t.datetime "vaccine_day"
    t.string "hospital_name"
    t.boolean "dermatitis"
    t.string "dermatitis_comment"
    t.boolean "disease"
    t.string "disease_comment"
    t.boolean "flea"
    t.string "flea_comment"
    t.text "customer_request"
    t.bigint "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.binary "images"
    t.index ["customer_id"], name: "index_pets_on_customer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booking_menus", "bookings"
  add_foreign_key "booking_menus", "menus"
  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "pets"
  add_foreign_key "enquetes", "customers"
  add_foreign_key "pets", "customers"
end
