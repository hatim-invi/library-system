class ChangeTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :racks, :rack
  end
end
