# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :initialize_var
  before_action :already_exist, only: :create
  before_action :authenticate_user!
  def create
    case params[:type]
    when 'Post'
      @like = @post.likes.new(user_id: current_user.id)
      flash[:notice] = 'Could not like the Post' unless @like.save
      redirect_to @post

    when 'Comment'
      @like = @comment.likes.new(user_id: current_user.id)
      flash[:notice] = 'Could not like the comment' unless @like.save
      redirect_to @comment.post
    end
  end

  def destroy
    case params[:type]
    when 'Post'
      @like = @post.likes.find(params[:like_id])

      flash[:notice] = 'Could not unlike the comment' unless @like.destroy
      redirect_to @post

    when 'Comment'
      @like = @comment.likes.find(params[:like_id])
      flash[:notice] = 'Could not unlike the comment' unless @like.destroy
      redirect_to @comment.post
    end
  end

  def index; end

  def show; end
end

private

def already_exist
  case params[:type]
  when 'Post'
    return unless @post.likes.exists?(user_id: current_user.id)

    flash[:notice] = 'Already Liked the Post'
    redirect_to @post
  when 'Comment'
    return unless @comment.likes.exists?(user_id: current_user.id)

    flash[:notice] = 'Already Liked the Comment'
    redirect_to @comment.post
  end
end

def initialize_var
  case params[:type]
  when 'Post'
    @post = Post.find_by_id(params[:id])
  when 'Comment'
    @comment = Comment.find_by_id(params[:id])
  end
end
