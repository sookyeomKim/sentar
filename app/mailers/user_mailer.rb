class UserMailer < ActionMailer::Base
  default from: "sentar247@gmail.com"

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
     @user = user
    mail to: user.email, subject: "Password reset"
  end

   def new_message(message, user)
     @message = message
    mail to: user.email, subject: "New message"
  end

  def reply_message(message)
     @message = message
    mail to: user.email, subject: "Reply message"
  end





end