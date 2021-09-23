# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find_by_id(params[:id]) || current_user
    @posts = @user.posts
  end

  def update
    current_user.update!(account_type: User.account_types[current_user.account_type] ^ 1)
    redirect_to current_user
  end
end
