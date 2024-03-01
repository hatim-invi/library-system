class AddDefaultInBookUploadFiles < ActiveRecord::Migration[7.1]
  def change
    change_column_default :book_upload_files, :correct_entries, from: nil, to: 0
    change_column_default :book_upload_files, :wrong_entries, from: nil, to: 0
  end
end
