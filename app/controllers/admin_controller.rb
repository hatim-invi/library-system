class AdminController < ApplicationController
  before_action :authorize
  def index
  end

  private
  def authorize
    if !session[:user_id].present?
      redirect_to '/', flash: {error: "Access Denied"}
    end
  end
end
