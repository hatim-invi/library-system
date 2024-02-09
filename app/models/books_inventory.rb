class BooksInventory < ApplicationRecord
    has_many :books_location
    has_many :books_rented

    def self.get_data(book_name_search_string)
        data =[]
        if book_name_search_string.present?
            data = BooksInventory.where("LOWER(book_name) LIKE ?", "%#{book_name_search_string.downcase}%")
        else
            data = BooksInventory.all
        end
    return data
    end


end
