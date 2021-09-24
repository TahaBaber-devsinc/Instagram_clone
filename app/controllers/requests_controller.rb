# frozen_string_literal: true

class RequestsController < ApplicationController
  def index
    @requests = Request.where(followee_id: current_user.id).includes(:user)
  end

  def create
    request = current_user.requests.new(followee_id: params[:id])
    redirect_to user_path(params[:id]), flash: { notice: 'Cannot request' } unless request.save
  end

  def destroy
    @request = current_user.requests.find_by_followee_id(params[:id])
    redirect_to user_path(params[:id]), flash: { notice: 'Cannot cancel' } unless @request.destroy
  end

  def accept
    user = User.find(params[:id])
    RequestAccept.new(user, current_user).call
    redirect_to current_user
  end

  def reject
    request = Request.find(params[:id])
    authorize request
    request.destroy
    redirect_to current_user
  end
end
