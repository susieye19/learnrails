class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  before_create :save_new_user

  def save_new_user
    return if email.include?('@example.com') and not Rails.env.production?

    # Remember to change this to your live secret key in production
    Stripe.api_key = ENV["STRIPE_API_KEY"]

    # Get the credit card details submitted by the form
    token = stripe_card_token

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 20000,
        :currency => "usd",
        :card => token,
        :description => "payinguser@example.com"
      )
      # flash[:success] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      # flash[:danger] = e.message
    end
  end
end
