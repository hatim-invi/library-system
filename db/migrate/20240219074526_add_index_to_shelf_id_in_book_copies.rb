class AddIndexToShelfIdInBookCopies < ActiveRecord::Migration[7.1]
  def change
    add_index :book_copies, :shelf_id
  end
end
