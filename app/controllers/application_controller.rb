class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    chapters_path
  end

  def require_admin
    if user_signed_in?
      unless current_user.admin?
        flash[:error] = "Only admins are allowed to see this page"
        redirect_to root_path
      end
    else
      flash[:error] = "Only admins are allowed to see this page"
      redirect_to root_path
    end
  end

  # def configure_permitted_parameters
  #   # devise_parameter_sanitizer.for(:sign_up) << :stripe_card_token
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   devise_parameter_sanitizer.for(:account_update) << :name
  # end
end
