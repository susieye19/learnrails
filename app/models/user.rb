class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  before_create :save_new_user

  def save_new_user
    return if email == 'alex@baserails.com'

    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = stripe_card_token

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 9900,
        :currency => "usd",
        :card => token,
        :description => "Charge for #{email}"
      )
      # flash[:success] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      # flash[:danger] = e.message
    end
  end
end
