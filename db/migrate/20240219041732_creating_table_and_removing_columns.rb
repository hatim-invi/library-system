class CreatingTableAndRemovingColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :book_width_in_cm, :integer
    remove_column :book_checkout_records, :is_returned
    remove_column :book_locations, :shelf
    remove_column :book_locations, :room
    remove_column :book_locations, :rack
    remove_column :book_locations, :section

    create_table :rooms do |t|
      t.string :room_number
      t.integer :maximum_section_capacity
      t.timestamps
    end

    create_table :sections do |t|
      t.string :name
      t.integer :maximum_rack_capacity
      t.references :room, foreign_key: true
      t.timestamps
    end

    create_table :racks do |t|
      t.string :name
      t.integer :maximum_shelf_capacity
      t.references :section, foreign_key: true
      t.timestamps
    end

    create_table :shelves do |t|
      t.string :name
      t.integer :shelf_length_in_cm
      t.references :rack, foreign_key: true
      t.timestamps
    end
  end
end
