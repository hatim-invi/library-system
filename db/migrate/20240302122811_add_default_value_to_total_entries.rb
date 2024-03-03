class AddDefaultValueToTotalEntries < ActiveRecord::Migration[7.1]
  def change
    change_column_default :book_upload_files, :total_entries, from: nil, to: 0
  end
end
