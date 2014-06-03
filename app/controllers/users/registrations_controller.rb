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

  def subscribe
  end

  def cancel
    puts "Checkpoint 1"
    @user = current_user
    if @user.pause_plan
      puts "Checkpoint 2"
      redirect_to edit_user_registration_path, notice: "Your current plan has been cancelled"
    else
      puts "Checkpoint 3"
      flash.alert = "Sorry, we were unable to cancel your plan"
      render :edit
    end
  end

  def update_plan
    @user = current_user
    plan = params[:user][:plan]
    if @user.update_plan(plan)
      redirect_to edit_user_registration_path, notice: "Your plan was updated!"
    else
      flash.alert = "Sorry, we were unable to update your plan"
      render :edit
    end
  end

  def update_card
    @user = current_user
    @user.stripe_card_token = params[:user][:stripe_card_token]
    if @user.save_with_payment
      redirect_to edit_user_registration_path, notice: "Your card was updated!"
    else
      flash.alert = "Sorry, we were unable to update your card"
      render :edit
    end
  end

  def update_both
    @user = current_user
    @user.plan = params[:user][:plan]
    @user.stripe_card_token = params[:user][:stripe_card_token]
    if @user.save_with_payment
      redirect_to subscribe_path, notice: "Thanks for subscribing!"
    else
      @user.plan = nil
      @user.save
      redirect_to subscribe_path, notice: "We weren't able to subscribe you"
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
    devise_parameter_sanitizer.for(:sign_up) << :coupon
    devise_parameter_sanitizer.for(:sign_up) << :plan
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :stripe_card_token
    devise_parameter_sanitizer.for(:account_update) << :plan
  end
end