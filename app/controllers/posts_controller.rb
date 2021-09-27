# frozen_string_literal: true

# class for posts controller
class PostsController < ApplicationController
  before_action :initialize_post, only: %i[show edit update destroy]

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    redirect_to current_user, flash: {notice: "Added post successfully"} and return if @post.save

    error_messages(@post)
    redirect_to new_post_path
  end

  def show; end

  def edit; end

  def update
    redirect_to @post, flash: {notice: "updated post successfully"} and return if @post.update(post_params)

    error_messages(@post)
    redirect_to edit_post_path
  end

  def destroy
    flash[:notice] = @post.destroy ? "Deleted successfully" : 'Could not Delete'
    redirect_to current_user
  end

  private

  def initialize_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
