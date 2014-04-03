class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    super

    # # Identify user and track 'Visit Signup Form' event
    # if user_signed_in?
    #   Analytics.identify(
    #     user_id: current_user.id,
    #     traits: {
    #       name: current_user.name,
    #       email: current_user.email,
    #       amount: current_user.amount
    #     }
    #   )
    #   Analytics.track(
    #     user_id: current_user.id,
    #     event: 'Visit Signup Form',
    #     context: {
    #       'Google Analytics' => {
    #         clientId: '471240751.1390206154'
    #       }
    #     }
    #   )
    # else
    #   Analytics.track(
    #     user_id: request.session_options[:id],
    #     event: 'Visit Signup Form',
    #     context: {
    #       'Google Analytics' => {
    #         clientId: '471240751.1390206154'
    #       }
    #     }
    #   )
    # end
  end

  def create
    build_resource(sign_up_params)

    if resource.save_with_payment

      # Alias anonymous user to user_id
      Analytics.alias(from: request.session_options[:id], to: resource.id)

      # Identify user and track both paid and free enrollments for Segment.io analytics
      if resource.amount > 0

        Analytics.identify(
          user_id: resource.id,
          traits: {
            name: resource.name,
            email: resource.email,
            amount: resource.amount
          }
        )

        Analytics.track(
          user_id: resource.id,
          event: 'Enrolled on Etsydemo - PAID',
          properties: {
            coupon: resource.coupon,
            amount: resource.amount
          },
          context: {
            'Google Analytics' => {
              clientId: '471240751.1390206154'
            }
          }
        )
      else
        Analytics.identify(
          user_id: resource.id,
          traits: {
            name: resource.name,
            email: resource.email,
            amount: "FREE"
          }
        )

        Analytics.track(
          user_id: resource.id,
          event: 'Enrolled on Etsydemo - FREE',
          properties: {
            coupon: resource.coupon,
            amount: resource.amount
          },
          context: {
            'Google Analytics' => {
              clientId: '471240751.1390206154'
            }
          }
        )
      end

      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    super
  end

  protected

  def after_sign_up_path_for(resource)
    thanks_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :stripe_card_token
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :coupon
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end