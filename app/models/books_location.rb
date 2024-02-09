class BooksLocation < ApplicationRecord
  belongs_to :books_inventory
  has_one :books_rented

  def self.get_locations(id)
    data=[]
    data = BooksLocation.where(books_inventory_id: id, is_there: true)
    return data
  end
end
