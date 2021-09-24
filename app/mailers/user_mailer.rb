# class for sending sign up mails
class UserMailer < ApplicationMailer
  def sign_up(user)
    mail to: user.email
  end
end
