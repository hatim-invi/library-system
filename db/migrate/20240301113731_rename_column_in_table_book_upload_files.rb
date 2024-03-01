class RenameColumnInTableBookUploadFiles < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_upload_files, :entries_performed, :correct_entries
    add_column :book_upload_files, :completed, :boolean, default:false
    add_column :book_upload_files, :wrong_entries, :integer
  end
end
