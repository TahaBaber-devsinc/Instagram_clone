# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.find params[:post_id]
    @comment = @post.comments.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    authorize @comment
    redirect_to @post and return if @comment.save

    flash[:notice] = 'Comment could not be empty'
    redirect_to new_post_comment_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    flash[:notice] = 'Cannot destroy' unless @comment.destroy
    redirect_to @comment.post
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
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
