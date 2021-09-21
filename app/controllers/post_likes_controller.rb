# frozen_string_literal: true

class PostLikesController < ApplicationController
  before_action :initialize_var
  before_action :already_exist, only: :create
  before_action :authenticate_user!
  def create
    @like = @post.likes.new(user_id: current_user.id)
    flash[:notice] = 'Could not like the Post' unless @like.save
    redirect_to @post
  end

  def destroy
    @like = @post.likes.find(params[:like_id])
    flash[:notice] = 'Could not unlike the comment' unless @like.destroy
    redirect_to @post
  end
end

private

def already_exist
  return unless @post.likes.exists?(user_id: current_user.id)

  flash[:notice] = 'Already Liked the Post'
  redirect_to @post
end

def initialize_var
  @post = Post.find_by_id(params[:id])
end
