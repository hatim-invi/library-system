class AddForeignKeyToBookCopies < ActiveRecord::Migration[7.1]
  def change
    add_column :book_copies, :shelf_id, :integer
    add_foreign_key :book_copies, :shelves,  column: :shelf_id
  end
end
