class Admin::BooksController < AdminController
  load_and_authorize_resource

  def index
    @books = Book.get_data(params[:query],params[:search_options]).paginate(page:params[:page],per_page:30)
  end

  def show
    @book = Book.find(params[:id])
    (@book_copies, @book_not_there) = BookCopy.get_copies(params[:id])
    @book_rented = BookCheckoutRecord.where(book_id: params[:id], returned_at: nil)
    if @book_rented.any?
      @book_rented_to = []
      @book_rented.each do |book|
        @book_rented_to << Member.find(book.member_id)
        end
    end
  end

  def edit
    @genres = Book.get_genres()
    @book = Book.find(params[:id])
  end

  def update
    @genres = Book.get_genres()
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def new
    @book = Book.new
    @genres = ["Select a genre"]
    @genres += Book.get_genres()
  end

  def create
    @genres = ["Select a genre"]
    @genres += Book.get_genres()

    # @book = Book.new(book_params.merge(search_key_for_name: book_params[:name].downcase, search_key_for_author: book_params[:author].downcase, search_key_for_genre: book_params[:genre]))
  #   if locations_params.blank? || locations_params.values.any? { |location| location.keys.sort != ['room', 'section', 'racker', 'shelf'] }
  #   @book.errors.add(:base, "Please provide valid location data for all locations")
  #   render :new, status: :unprocessable_entity
  #   return
  # end

      if @book.save
        redirect_to admin_book_path(@book)
      else
        render :new, status: :unprocessable_entity
      end
  end


  private
  def book_params
    params.require(:book).permit(:name, :author, :genre, :about, :published_on, :book_width_in_cm)
  end

  def locations_params
    params.permit(locations: [:room, :section, :racker, :shelf])
  end



end
