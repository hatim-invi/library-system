class HomeController < ApplicationController
  def index
    @home_display_books = BooksInventory.get_data(params[:query])
  end

  def show
    @book_info = BooksInventory.find(params[:id])
    @book_locations_data = BooksLocation.get_locations(params[:id])
    @book_locations = @book_locations_data.present?
    if !@book_locations
      @books_rented = BooksRented.find_by(books_inventory_id: params[:id])
      if @books_rented.is_a?(Enumerable)
        @books_rented = @books_rented.sort_by(&:return_by)
      end
    end
    # puts @books_rented
  end
end
