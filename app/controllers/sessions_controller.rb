class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/admin', notice: "Signed in Successfully"
    else
      flash[:alert] = "Username or password invalid"
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "logged out successfully"
  end

  private
end
