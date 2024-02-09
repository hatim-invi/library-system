class ChangeIsThereDefaultToTrueInBooksLocations < ActiveRecord::Migration[7.1]
  def change
    change_column_default :books_locations, :is_there, from: false, to: true
  end
end
