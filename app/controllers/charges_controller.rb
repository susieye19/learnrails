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
      :customer    => current_user.id,
      :amount      => @amount,
      :description => 'Extra access charge',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
