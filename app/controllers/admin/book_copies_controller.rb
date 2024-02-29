class Admin::BookCopiesController < AdminController
  before_action -> {set_available_locations(params[:book_width])}
  def rooms

    rooms = @available_locations.select('rooms.name').distinct.pluck('rooms.name')
    render json: rooms
  end

  def sections
    room = params[:room]
    sections = @available_locations.where('rooms.name = ?',room).select('sections.name').distinct.pluck('sections.name')
    render json: sections
  end

  def rackers
    room = params[:room]
    section = params[:section]
    rackers = @available_locations.where('rooms.name = ? AND sections.name = ?',room,section).select('rackers.name').distinct.pluck('rackers.name')
    render json: rackers
  end

  def shelfs
    room = params[:room]
    section = params[:section]
    racker = params[:racker]
    shelves = @available_locations.where('rooms.name = ? AND sections.name = ? AND rackers.name = ?',room,section,racker).select('shelves.name').distinct.pluck('shelves.name')
    render json: shelves
  end


  private

  def set_available_locations(current_book_width)
    if params[:book_width] == ""
      render json: [""]
      return
    end
    @available_locations ||= BookCopy.joins(:book, shelf: { racker: { section: :room } }).group(:shelf_id).having('SUM(books.book_width_in_cm) + ? < shelves.shelf_length_in_cm', current_book_width)
    if @available_locations.length == 0
      render json: ["No locations available"]
      return
    end
  end
end
