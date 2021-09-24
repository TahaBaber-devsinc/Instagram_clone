# frozen_string_literal: true

# main controller class
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username image])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :error_occurred

  private

  def error_occurred(exception)
    render html: { error: exception.message }, status: 404
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end
end
