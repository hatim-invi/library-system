class ChangeBookIdNullableInBookLocations < ActiveRecord::Migration[7.1]
  def change
    change_column :book_locations, :book_id, :integer, null: true
  end
end
