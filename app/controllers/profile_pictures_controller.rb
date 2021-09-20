# frozen_string_literal: true

class ProfilePicturesController < ApplicationController
  def new
    @user = current_user
  end

  def update
    current_user.image.attach(picture_params[:image])
    redirect_to current_user
  end

  private

  def picture_params
    params.require(:user).permit(:image)
  end
end
