class ChangeTableNameToRacks < ActiveRecord::Migration[7.1]
  def change
    rename_table :choclate, :rackers
    rename_column :shelves, :rack_id, :racker_id
    rename_column :rooms, :room_number, :name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
