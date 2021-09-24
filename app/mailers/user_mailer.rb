# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sign_up.subject
  #
  def sign_up(user)
    @greeting = 'Hi'

    mail to: user.email, subject: 'sign up'
  end
end
