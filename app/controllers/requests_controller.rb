# frozen_string_literal: true

# class that handles follow requests
class RequestsController < ApplicationController
  before_action :authorize_action, only: %i[create destroy]
  def index
    @requests = Request.includes(:user).where(followee_id: current_user.id)
    authorize(@requests, policy_class: RequestPolicy)
  end

  def create
    request = current_user.requests.new(followee_id: params[:id])
    redirect_to user_path(params[:id]), flash: { notice: 'Cannot request' } unless request.save
  end

  def destroy
    @request = current_user.requests.find_by(followee_id: params[:id])
    redirect_to user_path(params[:id]), flash: { notice: 'Cannot cancel' } unless @request.destroy
  end

  def accept
    user = User.find(params[:id])
    authorize(user, policy_class: RequestPolicy)
    RequestAccept.new(user, current_user).call
    redirect_to current_user
  end

  def reject
    request = Request.find(params[:id])
    authorize request
    request.destroy
    redirect_to current_user
  end

  private

  def authorize_action
    authorize(params[:id], policy_class: RequestPolicy)
  end
end
