class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :set_plan, only: [:new, :create]
  before_action :authenticate_user!, except: [:new, :create]

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
      super
    end
  end

  def create
    build_resource(sign_up_params)

    if @plan.blank?

      if resource.save
        # Send new user email notification
        UserMailer.new_user(resource.name, resource.email).deliver

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
      
    else

      if resource.save && resource.save_with_payment
        # Send new subscription email notification
        UserMailer.new_subscription(resource.name, resource.email, @plan).deliver

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
  end

  def subscribe
    if current_user.customer_id
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      
      @current_customer = Stripe::Customer.retrieve(current_user.customer_id)
      @card = @current_customer.cards.retrieve(@current_customer.cards.data[0]['id'])
      
      if current_user.plan
        @current_plan = Stripe::Plan.retrieve(current_user.plan)
        @subscription = @current_customer.subscriptions.try(:first)
      end
    end
  end

  def update_plan
    @user = current_user
    plan = params[:user][:plan]

    if @user.update_plan(plan)
      # Send edit subscription email notification
      UserMailer.edit_subscription(@user.name, @user.email, plan).deliver

      redirect_to subscribe_path, notice: "Your plan was updated!"
    else
      redirect_to subscribe_path, notice: "There was a problem with your plan information. Please try again."
    end
  end

  def update_card
    @user = current_user
    if @user.update_card(params[:user][:stripe_card_token])
      redirect_to subscribe_path, notice: "Your card was updated!"
    else
      redirect_to subscribe_path, notice: "There was a problem with your card information. Please try again."
    end
  end

  def update_both
    @user = current_user
    @user.plan = params[:user][:plan]
    @user.stripe_card_token = params[:user][:stripe_card_token]
    if @user.save_with_payment

      # Send legacy subscription email notification
      UserMailer.convert_to_paid(@user.name, @user.email, @user.plan).deliver

      redirect_to subscribe_path, notice: "Thanks for subscribing!"
    else
      @user.plan = nil
      @user.save
      redirect_to subscribe_path, notice: "There was a problem with your card information. Please try again."
    end
  end
  
  def cancel_plan
    @user = current_user
    if @user.cancel_plan
      redirect_to subscribe_path, notice: "Subscription cancelled - enjoy access until the end of your billing cycle"
    else
      redirect_to subscribe_path, notice: "We're having trouble cancelling your plan. Please email alex@baserails.com instead"
    end
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
    devise_parameter_sanitizer.for(:sign_up) << :plan
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :stripe_card_token
    devise_parameter_sanitizer.for(:account_update) << :plan
  end
end