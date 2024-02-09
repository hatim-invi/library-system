class ChangeSectionTypeInBooksLocations < ActiveRecord::Migration[7.1]
  def change
    change_column :books_locations, :section, :string
  end
end
