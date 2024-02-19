class ChangingColumnsAttribute < ActiveRecord::Migration[7.1]
  def change
    change_column_null :books, :author, true
    change_column_null :book_locations, :book_id, true
    change_column_null :book_locations, :room, true
    change_column_null :book_locations, :section, true
    change_column_null :book_locations, :shelf, true
    change_column_null :book_locations, :rack, true
    change_column_null :book_locations, :availability, true

    change_column_null :book_checkout_records, :book_id, true
    change_column_null :book_checkout_records, :return_by, true
    change_column_null :book_checkout_records, :rented_on, true
    change_column_null :book_checkout_records, :book_location_id, true
    change_column_null :book_checkout_records, :member_id, true

    change_column_null :members, :membership_start_date, true
    change_column_null :members, :membership_end_date, true
  end
end
