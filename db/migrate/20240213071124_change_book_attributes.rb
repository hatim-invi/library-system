class ChangeBookAttributes < ActiveRecord::Migration[7.1]
  def change
    rename_column :books, :book_name, :name

    change_column_null :books, :name, false
    change_column_null :books, :author, false
    change_column_null :books, :published_on, false
    change_column_null :books, :quantity, false
    change_column_null :books, :about, false
    change_column_null :books, :genre, false
    add_column :books, :search_key_for_name, :string
    add_column :books, :search_key_for_author, :string
    add_column :books, :search_key_for_genre, :string
    add_index :books, :search_key_for_name
    add_index :books, :search_key_for_author
    add_index :books, :search_key_for_genre
  end
end
