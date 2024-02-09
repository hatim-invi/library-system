class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.integer :adhaar_no, null: false
      t.string :name, null: false
      t.date :membership_start_date, null: false
      t.date :membership_end_date, null: false
      t.boolean :books_taken, default: 0, null: false

      t.timestamps
    end
  end
end
