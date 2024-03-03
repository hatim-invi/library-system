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

ActiveRecord::Schema[7.1].define(version: 2024_03_02_122811) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_checkout_records", force: :cascade do |t|
    t.bigint "book_id"
    t.date "rented_on"
    t.date "return_by"
    t.bigint "member_id"
    t.bigint "book_copy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "returned_at"
    t.index ["book_copy_id"], name: "index_book_checkout_records_on_book_copy_id"
    t.index ["book_id"], name: "index_book_checkout_records_on_book_id"
    t.index ["member_id"], name: "index_book_checkout_records_on_member_id"
  end

  create_table "book_copies", force: :cascade do |t|
    t.integer "book_id"
    t.boolean "availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shelf_id"
    t.index ["book_id"], name: "index_book_copies_on_book_id"
    t.index ["shelf_id"], name: "index_book_copies_on_shelf_id"
  end

  create_table "book_upload_files", force: :cascade do |t|
    t.string "file"
    t.integer "total_entries", default: 0
    t.integer "correct_entries", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "file_errors", default: [], array: true
    t.boolean "completed", default: false
    t.integer "wrong_entries", default: 0
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
    t.integer "book_width_in_cm"
    t.index ["search_key_for_author"], name: "index_books_on_search_key_for_author"
    t.index ["search_key_for_genre"], name: "index_books_on_search_key_for_genre"
    t.index ["search_key_for_name"], name: "index_books_on_search_key_for_name"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "members", force: :cascade do |t|
    t.string "adhaar_number"
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

  create_table "rackers", force: :cascade do |t|
    t.string "name"
    t.integer "maximum_shelf_capacity"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_rackers_on_section_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "maximum_section_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.integer "maximum_rack_capacity"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_sections_on_room_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name"
    t.integer "shelf_length_in_cm"
    t.bigint "racker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["racker_id"], name: "index_shelves_on_racker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string "role"
  end

  add_foreign_key "book_checkout_records", "book_copies"
  add_foreign_key "book_checkout_records", "books"
  add_foreign_key "book_checkout_records", "members"
  add_foreign_key "book_copies", "books"
  add_foreign_key "book_copies", "shelves"
  add_foreign_key "rackers", "sections"
  add_foreign_key "sections", "rooms"
  add_foreign_key "shelves", "rackers"
end
