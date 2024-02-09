class CreateBooksRenteds < ActiveRecord::Migration[7.1]
  def change
    create_table :books_renteds do |t|
      t.references :books_inventory, null: false, foreign_key: true
      t.date :rented_on, null: false
      t.date :return_by, null: false
      t.references :member, null: false, foreign_key: true
      t.references :books_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
