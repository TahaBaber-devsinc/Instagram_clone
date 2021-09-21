# frozen_string_literal: true

class FollowshipController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    authorize @followship
    flash[:notice] = 'Could not follow' unless @followship.save
    redirect_to user_path(params[:following_id])
  end

  def destroy
    @followship = current_user.followships.find_by_following_id(params[:following_id])
    @followship.destroy
    redirect_to user_path(params[:following_id])
  end

  # follow rest practices
  def followers
    @followers = User.find(params[:id]).followers
  end

  def followees
    @followees = User.find(params[:id]).followees
  end
end
