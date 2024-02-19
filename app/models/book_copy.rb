class BookCopy < ApplicationRecord
  belongs_to :book, optional: true
  has_one :book_checkout_record
  belongs_to :shelf

  def self.get_copies(id)
    book_copies = BookCopy.joins(shelf: { racker: { section: :room } }).where(book_id: id)
    book_copies
    book_not_there = false
    if book_copies.length==0
      book_not_there= true
      book_copies = BookCheckoutRecord.where(book_id: id)
      book_copies = book_copies.sort_by(&:return_by)
    end
    return [book_copies, book_not_there]
  end
end
