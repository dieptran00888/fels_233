class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:danger] = t "admin.application.flash_error"
    redirect_to root_path
  end
end
