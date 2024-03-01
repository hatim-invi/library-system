class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_upload_files, :errors, :file_errors
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
