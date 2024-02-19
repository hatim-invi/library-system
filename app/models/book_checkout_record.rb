class BookCheckoutRecord < ApplicationRecord
  belongs_to :book
  belongs_to :member
  has_one :book_copy
end
