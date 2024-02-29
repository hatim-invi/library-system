class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_or_username(params[:data])
    if user
      user.send_password_reset
    end
      redirect_to root_url, notice: "Email set with password reset instructions"
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to 'password_resets/new', notice: "Password reset expired"
    elsif @user.update(user_params)
      redirect_to root_url, notice: "Password has been reset"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end
end
