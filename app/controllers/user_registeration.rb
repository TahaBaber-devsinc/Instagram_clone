# frozen_string_literal: true

class UserRegisterationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.sign_up(@user).deliver_later if @user.persisted?
  end
end
