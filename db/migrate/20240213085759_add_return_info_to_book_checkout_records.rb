class AddReturnInfoToBookCheckoutRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :book_checkout_records, :is_returned, :boolean
    add_column :book_checkout_records, :returned_at, :datetime
  end
end
