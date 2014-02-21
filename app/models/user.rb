class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def save_with_payment
    if valid?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = stripe_card_token

      amount = 9900
      if coupon.upcase == "SWSD"
        amount = ((1 - 0.75)*amount).floor
      elsif coupon.upcase == "BROC"
        amount = ((1 - 0.50)*amount).floor
      elsif coupon.upcase == "BRSM"
        amount = ((1 - 0.50)*amount).floor
      elsif coupon.upcase == "EVENTSOC"
        amount = ((1 - 0.50)*amount).floor
      elsif coupon.upcase == "JEFF"
        amount = 2400
      end

      unless (coupon.upcase == "UDEMY") || (coupon.upcase == "RHONDA") || (coupon.upcase == "FREEACCESS")
        charge = Stripe::Charge.create(
          :amount => amount,
          :currency => "usd",
          :card => token,
          :description => "Charge for #{email}"
        )
      end
      save!
    end
  rescue Stripe::CardError => e
    errors.add :base, "There was a problem with your credit card."
    self.stripe_card_token = nil
    self.coupon = nil
    false
  rescue Stripe::InvalidRequestError => e
    errors.add :base, "#{e.message}"
    self.stripe_card_token = nil
    self.coupon = nil
    false
  end
end