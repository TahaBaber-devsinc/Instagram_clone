# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  before_action :require_same_id, only: :edit
  def index
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private

  def require_same_id
    return if current_user.id == params[:id].to_i

    flash[:error] = 'You cannot access this id'
    redirect_to root_path
  end
end
