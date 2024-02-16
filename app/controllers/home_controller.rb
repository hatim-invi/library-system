class HomeController < ApplicationController
  def index
    @books = Book.get_data(params[:query],params[:search_options]).paginate(page: params[:page], per_page: 30)
  end

  def show
    @book = Book.find(params[:id])
    (@book_location_data, @book_not_there) = BookLocation.get_locations(params[:id])
  end
end
