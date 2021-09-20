# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to current_user
    else
      redirect_to new_post_path
      @post.errors.messages.each do |_key, value|
        flash[:notice] = value.first
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to edit_post_path
      @post.errors.messages.each do |_key, value|
        flash[:notice] = value.first
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    flash[:notice] = 'Could not Delete' unless @post.destroy
    redirect_to current_user
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
