class Admin::BookLocationsController < ApplicationController
  def rooms
    available_rooms = BookLocation.group(:room, :section, :rack, :shelf).having(availability:false).pluck(:room).group_by(&:itself).keys
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
