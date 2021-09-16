# frozen_string_literal: true

class FollowshipController < ApplicationController
  before_action :follow_check, only: :create
  before_action :same_user, only: :create
  def create
    puts "\n\n\nhere\n\n\n\n"
    @followship = current_user.followships.build(following_id: params[:following_id])
    flash[:notice] = 'Could not follow' unless @followship.save
  end

  def destroy
    @followship = current_user.followships.find_by_following_id(params[:following_id])
    @followship.destroy
  end

  def followers
    @followers = User.find(params[:id]).followers
  end

  def followees
    @followees = User.find(params[:id]).followees
  end

  private

  def follow_check
    puts "\n\n\nhere\n\n\n\n"
    if current_user.followships.exists?(following_id: params[:following_id])

      flash[:notice] = 'Already Following this user'
      redirect_to user_path(params[:following_id])
    end
  end

  def same_user
    if current_user.id == params[:following_id].to_i

      flash[:notice] = 'Cannot follow Self'
      redirect_to user_path(params[:following_id])
    end
  end
end
