class Shelf < ApplicationRecord
belongs_to :racker
has_many :book_copies
end
