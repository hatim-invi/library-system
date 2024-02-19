class AddToSectionInBooksLocations < ActiveRecord::Migration[7.1]
  def change
    change_column :books_locations, :section, :string, null:false
  end
end
