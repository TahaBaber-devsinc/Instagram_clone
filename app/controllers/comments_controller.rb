# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.find params[:post_id]
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    param = comment_params
    param [:user_id] = current_user.id
    @comment = @post.comments.new(param)
    redirect_to @post and return if @comment.save

    flash[:notice] = 'Comment could not be empty'
    redirect_to new_post_comment_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    flash[:notice] = 'Cannot destroy' unless @comment.destroy
    redirect_to @comment.post
  end

  def edit
    @comment = current_user.comments.find_by_id(params[:id])
    return unless @comment.nil?

    flash[:notice] = 'Cannot Update this Comment'
    redirect_to current_user
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment.post
    else
      redirect_to edit_post_path
      flash[:notice] = "Can't leave comment blank"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
