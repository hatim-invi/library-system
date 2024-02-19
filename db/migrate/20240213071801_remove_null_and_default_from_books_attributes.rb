class RemoveNullAndDefaultFromBooksAttributes < ActiveRecord::Migration[7.1]
  def change

    change_column_null :books, :name, true
    change_column_default :books, :quantity, nil
    change_column_null :books, :quantity, true
    change_column_null :books, :published_on, true
    change_column_null :books, :about, true
    change_column_null :books, :genre, true
    change_column_null :books, :author, true

  end
end
