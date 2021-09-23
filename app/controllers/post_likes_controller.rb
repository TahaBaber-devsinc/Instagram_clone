# frozen_string_literal: true

class PostLikesController < ApplicationController
  before_action :initialize_post
  before_action :already_exist, only: :create
  before_action :authenticate_user!

  def create
    like = @post.likes.new(user_id: current_user.id)
    redirect_to @post, flash: { notice: 'Could not like the Post' } unless like.save
  end

  def destroy
    like = @post.likes.find_by!(user_id: current_user.id)
    redirect_to @post, flash: { notice: 'Could not unlike the Post' } unless like.destroy
  end

  private

  def already_exist
    return unless @post.likes.exists?(user_id: current_user.id)

    flash[:notice] = 'Already Liked the Post'
    redirect_to @post
  end

  def initialize_post
    @post = Post.find(params[:id])
  end
end
