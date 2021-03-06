# frozen_string_literal: true

# class for comments on posts
class CommentsController < ApplicationController
  before_action :initialize_post, only: %i[new create]
  before_action :initialize_comment, only: %i[destroy edit update]

  def new
    @comment = @post.comments.new
    authorize @comment
  end

  def create
    comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    authorize comment
    redirect_to @post, flash: { notice: 'Added comment successfully' } and return if comment.save

    redirect_to new_post_comment_path, flash: { notice: 'Comment could not be empty' }
  end

  def destroy
    flash[:notice] = @comment.destroy ? 'Deleted successfully' : 'Cannot destroy'
    redirect_to @comment.post
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.post,
                  flash: { notice: 'Updated comment successfully' } and return
    end

    redirect_to edit_comment_path(params[:id]), flash: { notice: "Can't leave comment blank" }
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
