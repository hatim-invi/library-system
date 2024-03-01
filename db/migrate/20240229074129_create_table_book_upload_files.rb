class CreateTableBookUploadFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :book_upload_files do |t|
      t.string :filename
      t.text :errors
      t.integer :total_enrtires
      t.integer :entries_performed
      t.timestamps
    end
  end
end
