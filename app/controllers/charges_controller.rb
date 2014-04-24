class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    @amount = 2500

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Extra access charge',
      :currency    => 'usd'
    )

    current_user.update_attribute(:extra_access, true)
    redirect_to videos_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
