class RenameColumnInBookCheckoutRecords < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_checkout_records, :book_location_id, :book_copy_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
