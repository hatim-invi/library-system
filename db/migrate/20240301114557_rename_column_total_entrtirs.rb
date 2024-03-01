class RenameColumnTotalEntrtirs < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_upload_files, :total_enrtires, :total_entries
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
