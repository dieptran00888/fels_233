class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include LessonsHelper
  include ActivitiesHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:danger] = t "admin.application.flash_error"
    redirect_to root_path
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::ATTRIBUTES_PARAMS
  end
end
