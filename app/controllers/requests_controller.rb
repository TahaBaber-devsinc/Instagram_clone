class RequestsController < ApplicationController
  def index
    @requests = Request.where(followee_id: current_user.id).includes(:user)
  end

  def create
    @request = current_user.requests.new(followee_id: params[:id])
    flash[:notice] = 'Cannot request' unless @request.save
    redirect_to user_path(params[:id])
  end

  def destroy
    @request = current_user.requests.find_by_followee_id(params[:id])
    flash[:notice] = 'Cannot cancel' unless @request.destroy
    redirect_to user_path(params[:id])
  end

  def accept
    @user = User.find(params[:id])
    @request = @user.requests.find_by_followee_id(current_user.id)
    @request.destroy
    @followship = @user.followships.build(following_id: current_user.id)
    @followship.save
    redirect_to current_user
  end

  def reject
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to current_user
  end
end
