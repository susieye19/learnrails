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

      if coupon.blank?
        amount = 9900
      elsif coupon.upcase == "SWSD"
        amount = 2500
      elsif coupon.upcase == "BROC"
        amount = 5000
      elsif coupon.upcase == "BRSM"
        amount = 5000
      elsif coupon.upcase == "EVENTSOC"
        amount = 5000
      elsif coupon.upcase == "BETASPRING"
        amount = 5000
      elsif coupon.upcase == "UDEMY"
        amount = 0
      elsif coupon.upcase == "FREEACCESS"
        amount = 0
      elsif coupon.upcase == "WAIHON"
        amount = 3500
      end

      if amount > 0
        charge = Stripe::Charge.create(
          :amount => amount,
          :currency => "usd",
          :card => token,
          :description => "Charge for #{email}"
        )
      end

      self.amount = amount/100.0
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