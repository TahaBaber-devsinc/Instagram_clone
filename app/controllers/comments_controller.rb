# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_post, only: %i[new create]
  before_action :initialize_comment, only: %i[destroy edit update]

  def new
    @comment = @post.comments.new
    authorize @comment
  end

  def create
    comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    authorize comment
    redirect_to @post and return if comment.save

    redirect_to new_post_comment_path, flash: { notice: 'Comment could not be empty' }
  end

  def destroy
    flash[:notice] = 'Cannot destroy' unless @comment.destroy
    redirect_to @comment.post
  end

  def edit; end

  def update
    redirect_to @comment.post and return if @comment.update(comment_params)

    redirect_to edit_post_path flash[:notice] = "Can't leave comment blank"
  end

  private

  def initialize_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def initialize_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
