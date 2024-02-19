class RenameTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :book_locations, :book_copies
  end
end
