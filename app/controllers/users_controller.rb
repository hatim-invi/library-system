class UsersController < ApplicationController
  load_and_authorize_resource
  def new
    @user = User.new()
    @roles = ["Select a role"]
    @roles += User.get_roles()
  end

  def create
    @user = User.new(user_params)
    @roles = ["Select a role"]
    @roles += User.get_roles()
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/admin', notice: "You Are Signed Up"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password,:password_confirmation, :role)
  end
end
