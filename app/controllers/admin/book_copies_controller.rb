class Admin::BookCopiesController < ApplicationController
  def rooms
    current_book_width = 3
    available_rooms = BookCopy.joins(:book,:shelf).group(:shelf_id).having('SUM(books.book_width_in_cm)+ ? < shelves.shelf_length_in_cm',current_book_width).pluck(:shelf_id)
    puts available_rooms
    render json: available_rooms
  end

  def sections
    room = params[:room]
    available_sections = BookLocation.where(room: room).group(:section, :rack, :shelf).having(availability:false).pluck(:section).group_by(&:itself).keys
    render json: available_sections
    puts "hi#{params[:seaarchTerm]}"
  end

  def racks
    room = params[:room]
    section = params[:section]
    available_racks = BookLocation.where(room: room, section: section).group(:rack, :shelf).having(availability:false).pluck(:rack).group_by(&:itself).keys
    render json: available_racks
  end

  def shelfs
    room = params[:room]
    section = params[:section]
    rack = params[:rack]
    available_racks = BookLocation.where(room: room, section: section, rack: rack,availability: false).pluck(:shelf)
    render json: available_racks
  end
end
