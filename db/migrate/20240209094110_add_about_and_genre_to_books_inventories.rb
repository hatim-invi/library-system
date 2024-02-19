class AddAboutAndGenreToBooksInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :books_inventories, :about, :text, null: false
    add_column :books_inventories, :genre, :string, null: false
  end
end
