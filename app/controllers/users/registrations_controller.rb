class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  # def create
  #   build_resource(sign_up_params)

  #   if resource.save
  #     yield resource if block_given?
  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_flashing_format?
  #       sign_up(resource_name, resource)
  #       respond_with resource, :location => after_sign_up_path_for(resource)
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #       expire_data_after_sign_in!
  #       respond_with resource, :location => after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords resource
  #     respond_with resource
  #   end
  # end

  protected

  def after_sign_up_path_for(resource)
    chapters_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:stripe_card_token)
  end
end