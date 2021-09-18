# frozen_string_literal: true

class ProfilePicturesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
  end

  def show; end

  def edit; end

  def update
    @user = User.find(params[:user_id])
    @user.image.attach(picture_params[:image])
    redirect_to current_user
  end

  def destroy; end

  private

  def picture_params
    params.require(:user).permit(:image)
  end
end
