class RemoveQuantityColumnFromBookTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :quantity
  end
end
