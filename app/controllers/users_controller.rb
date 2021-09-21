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
    current_user.account_type == 'Public' ? current_user.update!(account_type: 'Private') : current_user.update!(account_type: 'Public')
    redirect_to current_user
  end
end
