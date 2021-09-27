# frozen_string_literal: true

# class for users profiles pictures
class ProfilePicturesController < ApplicationController
  def new
    @user = current_user
    authorize @user
  end

  def update
    current_user.image.attach(picture_params[:image])
    authorize current_user
    if current_user.image.persisted?
      redirect_to current_user,
                  flash: { notice: 'updated image successfully' } and return
    end

    error_messages(current_user)
    redirect_to new_user_profile_picture_path
  end

  private

  def picture_params
    flash[:notice] = "Image can't be blank " and return {} if params[:user].blank?

    params.require(:user).permit(:image)
  end
end
