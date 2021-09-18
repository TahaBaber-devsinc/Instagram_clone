# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  before_action :require_same_id, only: %i[edit update]
  def index
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    current_user.account_type == 'Public' ? current_user.update!(account_type: 'Private') : current_user.update!(account_type: 'Public')
    redirect_to current_user
  end

  private

  def require_same_id
    return if current_user.id == params[:id].to_i

    flash[:error] = 'You cannot access this id'
    redirect_to root_path
  end
end
