class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    super
  end

  def create
    build_resource(sign_up_params)

    # if resource.save
    #   begin
    #     Stripe.api_key = ENV["STRIPE_API_KEY"]
    #     token = params[:user][:stripe_card_token]
    #     logger.info "Stripe card token is #{params[:user][:stripe_card_token]}"

    #     charge = Stripe::Charge.create(
    #       :amount => 9900,
    #       :currency => "usd",
    #       :card => token,
    #       :description => %Q[Charge for #{params[:user][:email]}]
    #     )
    #     redirect_to root_url
    #   rescue Stripe::CardError => e
    #     resource.errors.add :base, "There was a problem with your credit card."
    #     # self.stripe_card_token = nil
    #     false
    #   rescue Stripe::InvalidRequestError => e
    #     # resource.errors.add :base, "Stripe::InvalidRequestError"
    #     # self.stripe_card_token = nil
    #     redirect_to root_url, flash[:error] = "Invalid Request Error"
    #   end
    # end

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