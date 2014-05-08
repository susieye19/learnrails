class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # Select which layout to use based on whether user is signed in
  layout :layout_by_resource

  helper_method :currently_signed_in_user

  protected

  def after_sign_in_path_for(resource)
    chapters_path
  end

  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "application_signed_out"
    end
  end

  def currently_signed_in_user
    return current_user
  end

  # def configure_permitted_parameters
  #   # devise_parameter_sanitizer.for(:sign_up) << :stripe_card_token
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   devise_parameter_sanitizer.for(:account_update) << :name
  # end
end
