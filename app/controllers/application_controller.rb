# frozen_string_literal: true

# main controller class
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username image])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordInvalid, with: :error_occurred
  rescue_from ActionController::ParameterMissing, with: :error_occurred

  private

  def error_occurred(exception)
    render html: helpers.tag.h1(exception.message), status: :not_found
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  def error_messages(model_obj)
    model_obj.errors.each { |error| flash[:notice] = error.full_message }
  end
end
