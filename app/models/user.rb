class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :stripe_card_token

  has_many :questions, dependent: :destroy
  validates :name, presence: true
  before_destroy :delete_subscription

  def save_with_payment
    if customer_id.nil?
      # Create new Stripe customer
      if coupon.blank?
        customer = Stripe::Customer.create(
          email: email,
          description: name,
          card: stripe_card_token,
          plan: plan
        )
      else
        customer = Stripe::Customer.create(
          email: email,
          description: name,
          card: stripe_card_token,
          plan: plan,
          coupon: coupon
        )
      end
    else
      # Update Stripe customer info
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_card_token.present?
        customer.card = stripe_card_token
      end
      customer.email = email
      customer.description = name
      customer.save
    end

    # Save Stripe information to User database
    self.customer_id = customer.id
    self.last_4_digits = customer.cards.retrieve(customer.default_card).last4
    self.stripe_card_token = nil
    self.save
  rescue Stripe::StripeError => e
    errors.add :base, "#{e.message}"
    self.stripe_card_token = nil
    false
  end

  def update_plan(plan)
    if self.plan == plan
      puts "HELLOOOO"
    else
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.first
      subscription.plan = plan
      subscription.save

      self.plan = plan
      self.save
    end
  rescue Stripe::StripeError => e
    puts e.message
    errors.add :base, "We couldn't update your subscription. #{e.message}"
    false
  end

  def cancel_plan
    unless plan.blank?
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.first.delete()

      self.plan = nil
      self.save
    end
  end

private

  def delete_subscription
    if self.plan.present?
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.first.delete()
      UserMailer.unsubscribe_notification(self.name, self.email, self.plan).deliver
    end
  end

  #   if valid?
  #     Stripe.api_key = ENV["STRIPE_API_KEY"]
  #     token = stripe_card_token

  #     if coupon.blank?
  #       amount = 14900
  #       self.extra_access = true
  #     else
  #       Coupon.all.each do |c|
  #         if coupon.upcase == c.code.upcase
  #           amount = c.price
  #           self.extra_access = c.extra_access
  #         end
  #       end
  #     end

  #     if amount > 0
  #       charge = Stripe::Charge.create(
  #         :amount => amount,
  #         :currency => "usd",
  #         :card => token,
  #         :description => "Charge for #{email}"
  #       )
  #     end

  #     self.amount = amount/100.0
  #     save!
  #   end
  # rescue Stripe::CardError => e
  #   errors.add :base, "There was a problem with your credit card."
  #   self.stripe_card_token = nil
  #   self.coupon = nil
  #   false
  # rescue Stripe::InvalidRequestError => e
  #   errors.add :base, "#{e.message}"
  #   self.stripe_card_token = nil
  #   self.coupon = nil
  #   false
  # end
end