class ChangeAdhaarNumberType < ActiveRecord::Migration[7.1]
  def change
    change_column :members, :adhaar_number, :string
    remove_column :book_upload_files, :errors
    add_column :book_upload_files, :errors_array, :text, array: true, default: []
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
