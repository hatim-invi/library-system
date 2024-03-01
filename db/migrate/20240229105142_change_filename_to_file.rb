class ChangeFilenameToFile < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_upload_files, :filename, :file
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
