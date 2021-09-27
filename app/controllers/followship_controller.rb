# frozen_string_literal: true

# class to handle follow/follower relation
class FollowshipController < ApplicationController
  def create
    followship = current_user.followships.build(following_id: params[:following_id])
    authorize followship
    redirect_to user_path(params[:following_id]), flash: { notice: 'Could not follow' } unless followship.save
  end

  def destroy
    followship = current_user.followships.find_by(following_id: params[:following_id])
    authorize followship
    redirect_to user_path(params[:following_id]), flash: { notice: 'Could not unfollow' } unless followship.destroy
  end
end
