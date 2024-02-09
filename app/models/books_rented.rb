class BooksRented < ApplicationRecord
  belongs_to :books_inventory
  belongs_to :member
  belongs_to :books_location
end
