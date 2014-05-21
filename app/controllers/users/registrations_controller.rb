class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :set_plan, only: [:new, :create]

  def new
    if @plan
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      begin
        Stripe::Plan.retrieve(@plan)
        super
      rescue => e
        redirect_to pricing_path, notice: "Nice try! You'll need to choose from one of the plans below :-)"
      end
    else
      redirect_to pricing_path, notice: "You'll need to choose a plan first before you can sign up!"
    end
  end

  def create
    build_resource(sign_up_params)

    if resource.save_with_payment

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

  def build_resource(*args)
    super
    if params[:plan]
      resource.plan = params[:plan]
    end
  end

  def set_plan
    @plan = params[:plan] || params[:user].try(:[], :plan)
  end

  def after_sign_up_path_for(resource)
    thanks_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :stripe_card_token
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :coupon
    devise_parameter_sanitizer.for(:sign_up) << :plan
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end