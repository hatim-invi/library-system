class ChangeAdhaarNoColumnAttribute < ActiveRecord::Migration[7.1]
  def change
    change_column_null :members, :adhaar_no, true
    rename_column :members, :adhaar_no, :adhaar_number
  end
end
