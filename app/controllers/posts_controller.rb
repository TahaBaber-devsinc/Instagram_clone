# frozen_string_literal: true

# class for posts controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_post, only: %i[show action update destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    redirect_to current_user and return if @post.save

    error_messages
    redirect_to new_post_path
  end

  def show; end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    redirect_to @post and return if @post.update(post_params)

    error_messages
    redirect_to edit_post_path
  end

  def destroy
    flash[:notice] = 'Could not Delete' unless @post.destroy
    redirect_to current_user
  end

  private

  def initialize_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def error_messages
    @post.errors.each { |error| flash[:notice] = error.full_message }
  end

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
