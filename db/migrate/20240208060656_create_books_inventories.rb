class CreateBooksInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :books_inventories do |t|
      t.string :book_name, null: false
      t.string :author, null: false
      t.date :published_on, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
