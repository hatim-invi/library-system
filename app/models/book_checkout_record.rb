class BookCheckoutRecord < ApplicationRecord
  belongs_to :book
  belongs_to :member
  belongs_to :book_location
end
