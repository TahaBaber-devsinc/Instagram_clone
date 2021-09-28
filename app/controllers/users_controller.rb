# frozen_string_literal: true

# class for users
class UsersController < ApplicationController
  before_action :authorize_user
  rescue_from ActiveRecord::ActiveRecordError, with: :handle_active_record_exception

  def index
    @users = params[:search].blank? ? User.all : User.search(params[:search])
  end

  def show
    @user = User.find_by(id: params[:id]) || current_user
    @posts = @user.posts
  end

  def update
    Request.where(followee_id: current_user.id).each { |request| RequestAccept.new(request.user, current_user).call }
    current_user.update(account_type: User.account_types[current_user.account_type] ^ 1)
  end

  private

  def authorize_user
    authorize(current_user, policy_class: UserPolicy)
  end

  def handle_active_record_exception(exception)
    redirect_to current_user, flash: { notice: exception.message }
  end
end
