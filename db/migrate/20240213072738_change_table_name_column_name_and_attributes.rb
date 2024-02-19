class ChangeTableNameColumnNameAndAttributes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :books, :author, false
    change_column_null :books_locations, :books_inventory_id, false
    change_column_null :books_locations, :room, false
    change_column_null :books_locations, :section, false
    change_column_null :books_locations, :shelf, false
    change_column_null :books_locations, :rack, false
    change_column_null :books_locations, :is_there, false
    change_column_default :books_locations, :is_there, nil

    change_column_null :books_renteds, :books_inventory_id, false
    change_column_null :books_renteds, :return_by, false
    change_column_null :books_renteds, :rented_on, false
    change_column_null :books_renteds, :books_location_id, false
    change_column_null :books_renteds, :member_id, false

    change_column_null :members, :membership_start_date, false
    change_column_null :members, :membership_end_date, false


    rename_column :books_locations, :is_there, :availability
    rename_column :books_locations, :books_inventory_id, :book_id
    rename_column :books_renteds, :books_inventory_id, :book_id
    rename_column :books_renteds, :books_location_id, :book_location_id
    remove_column :members, :name
    remove_column :members, :books_taken
    add_column :members, :name, :string
    add_column :members, :surname, :string
    add_column :members, :search_key_for_name, :string
    add_column :members, :search_key_for_surname, :string
    add_index :members, :search_key_for_name
    add_index :members, :search_key_for_surname
    add_index :members, :adhaar_no

    rename_table :books_locations, :book_locations
    rename_table :books_renteds, :book_checkout_records
  end
end
