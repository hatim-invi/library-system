class RenameBooksInventoriesTableNameToBooksTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :books_inventories, :books
  end
end
