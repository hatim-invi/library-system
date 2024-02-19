class ChangeTableNameToChoclate < ActiveRecord::Migration[7.1]
  def change
    rename_table :rack, :choclate
  end
end
