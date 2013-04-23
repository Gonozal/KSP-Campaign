class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  load_and_authorize_resource unless: :devise_controller?

  # Cancan permission denied redirect
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end

  # Strong params for devise
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  # Strong params helper method for devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email) }
  end
end
