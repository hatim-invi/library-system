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

ActiveRecord::Schema[7.1].define(version: 2024_02_09_094110) do
  create_table "books_inventories", force: :cascade do |t|
    t.string "book_name", null: false
    t.string "author", null: false
    t.date "published_on", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about", null: false
    t.string "genre", null: false
  end

  create_table "books_locations", force: :cascade do |t|
    t.integer "books_inventory_id", null: false
    t.integer "room", null: false
    t.string "section", null: false
    t.integer "rack", null: false
    t.integer "shelf", null: false
    t.boolean "is_there", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["books_inventory_id"], name: "index_books_locations_on_books_inventory_id"
  end

  create_table "books_renteds", force: :cascade do |t|
    t.integer "books_inventory_id", null: false
    t.date "rented_on", null: false
    t.date "return_by", null: false
    t.integer "member_id", null: false
    t.integer "books_location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["books_inventory_id"], name: "index_books_renteds_on_books_inventory_id"
    t.index ["books_location_id"], name: "index_books_renteds_on_books_location_id"
    t.index ["member_id"], name: "index_books_renteds_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.integer "adhaar_no", null: false
    t.string "name", null: false
    t.date "membership_start_date", null: false
    t.date "membership_end_date", null: false
    t.boolean "books_taken", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books_locations", "books_inventories"
  add_foreign_key "books_renteds", "books_inventories"
  add_foreign_key "books_renteds", "books_locations"
  add_foreign_key "books_renteds", "members"
end
