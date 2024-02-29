class UserMailer < ApplicationMailer
default from: "hatim.invi@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    puts "inside mailer"
    mail to: user.email, subject: "Reset password"
  end
end
