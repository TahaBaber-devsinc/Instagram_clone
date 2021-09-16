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
  end

  def edit
    @post = current_user.posts.find_by_id(params[:id])
    if @post.nil?
      flash[:notice] = 'Cannot Update caption of this post'
      redirect_to current_user
    end
  end

  def update
    @post = current_user.posts.find_by_id(params[:id])

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
    @post = current_user.posts.find_by_id(params[:id])
    if @post.nil?
      flash[:notice] = 'Could not Delete this post'
      redirect_to current_user
    elsif @post.destroy
      redirect_to current_user
    else
      flash[:notice] = 'Could not Delete'
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
