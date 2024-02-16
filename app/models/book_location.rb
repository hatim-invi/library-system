class BookLocation < ApplicationRecord
  belongs_to :book, optional: true
  has_one :book_checkout_record

  def self.get_locations(id)
    book_location_data = BookLocation.where(book_id: id)
    book_not_there = false
    if book_location_data.length==0
      book_not_there= true
      book_location_data = BookCheckoutRecord.where(book_id: id)
      book_location_data = book_location_data.sort_by(&:return_by)
    end
    return [book_location_data, book_not_there]
  end
end
