# frozen_string_literal: true

# class for users profiles pictures
class ProfilePicturesController < ApplicationController
  def new
    @user = current_user
  end

  def update
    current_user.image.attach(picture_params[:image])
    error_messages if current_user.image.persisted?
    redirect_to current_user if current_user.image.persisted?
  end

  private

  def picture_params
    params.require(:user).permit(:image)
  end

  def error_messages
    current_user.errors.each { |error| flash[:notice] = error.full_message }
  end
end
