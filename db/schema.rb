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

ActiveRecord::Schema[7.1].define(version: 2024_02_16_035439) do
  create_table "book_checkout_records", force: :cascade do |t|
    t.integer "book_id"
    t.date "rented_on"
    t.date "return_by"
    t.integer "member_id"
    t.integer "book_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_returned"
    t.datetime "returned_at"
    t.index ["book_id"], name: "index_book_checkout_records_on_book_id"
    t.index ["book_location_id"], name: "index_book_checkout_records_on_book_location_id"
    t.index ["member_id"], name: "index_book_checkout_records_on_member_id"
  end

  create_table "book_locations", force: :cascade do |t|
    t.integer "book_id"
    t.integer "room"
    t.string "section"
    t.integer "rack"
    t.integer "shelf"
    t.boolean "availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_locations_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.string "genre"
    t.string "search_key_for_name"
    t.string "search_key_for_author"
    t.string "search_key_for_genre"
    t.index ["search_key_for_author"], name: "index_books_on_search_key_for_author"
    t.index ["search_key_for_genre"], name: "index_books_on_search_key_for_genre"
    t.index ["search_key_for_name"], name: "index_books_on_search_key_for_name"
  end

  create_table "members", force: :cascade do |t|
    t.integer "adhaar_number"
    t.date "membership_start_date"
    t.date "membership_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "search_key_for_name"
    t.string "search_key_for_surname"
    t.index ["adhaar_number"], name: "index_members_on_adhaar_number"
    t.index ["search_key_for_name"], name: "index_members_on_search_key_for_name"
    t.index ["search_key_for_surname"], name: "index_members_on_search_key_for_surname"
  end

  add_foreign_key "book_checkout_records", "book_locations"
  add_foreign_key "book_checkout_records", "books"
  add_foreign_key "book_checkout_records", "members"
  add_foreign_key "book_locations", "books"
end
