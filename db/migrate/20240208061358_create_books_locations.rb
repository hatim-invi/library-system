class CreateBooksLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :books_locations do |t|
      t.references :books_inventory, null: false, foreign_key: true
      t.integer :room, null: false
      t.integer :section, null: false
      t.integer :rack, null: false
      t.integer :shelf, null: false
      t.boolean :is_there, default: false, null: false

      t.timestamps
    end
  end
end
