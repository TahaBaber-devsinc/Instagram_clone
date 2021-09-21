# frozen_string_literal: true

class CommentLikesController < ApplicationController
  before_action :initialize_comment
  before_action :already_exist, only: :create
  before_action :authenticate_user!

  def create
    @like = @comment.likes.new(user_id: current_user.id)
    flash[:notice] = 'Could not like the comment' unless @like.save
    redirect_to @comment.post
  end

  def destroy
    like = @comment.likes.find(params[:like_id])
    flash[:notice] = 'Could not unlike the comment' unless like.destroy
    redirect_to @comment.post
  end
end

private

def already_exist
  return unless @comment.likes.exists?(user_id: current_user.id)

  flash[:notice] = 'Already Liked the Comment'
  redirect_to @comment.post
end

def initialize_comment
  @comment = Comment.find_by_id(params[:id])
end
