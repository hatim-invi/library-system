class ChangeColumnTypeOfErrorsArray < ActiveRecord::Migration[7.1]
  def change
    remove_column :book_upload_files, :errors_array
    add_column :book_upload_files, :errors, :json, array:true, default:[]
  end
end
