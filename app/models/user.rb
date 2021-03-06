class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :stripe_card_token
  
  # Used for the acts_as_votable gem
  acts_as_voter

  has_many :comments
  has_many :questions, dependent: :destroy
  validates :name, presence: true
  before_destroy :delete_subscription

  def save_with_payment
    begin
      if customer_id.nil?
        
        # Check coupon validity, set to false by default
        validity = false
        if coupon.present?
          Coupon.all.each do |c|
            if coupon == c.code
              @coupon = c
              validity = true
            end
          end
        end
        
        if validity == false # If no/invalid coupon, sign up for a Stripe subscription as usual
          # Create new Stripe customer
          customer = Stripe::Customer.create(
            email: email,
            description: name,
            card: stripe_card_token,
            plan: plan
          )
        else # If valid coupon present, save user and delete coupon code from database
          self.stripe_card_token = nil
          self.plan = "stacksocial"
          return self.save
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
  end

  def update_plan(plan)
    customer = Stripe::Customer.retrieve(customer_id)

    # Add a new plan if one doesn't exist
    if customer.subscriptions['total_count'] == 0
      customer.subscriptions.create(plan: plan)

    # Otherwise, update the existing plan
    else
      subscription = customer.subscriptions.first
      subscription.plan = plan
      subscription.save
    end

    self.plan = plan
    self.save
    
  rescue Stripe::StripeError => e
    puts e.message
    errors.add :base, "We couldn't update your subscription. #{e.message}"
    false
  end
  
  def update_card(token)
    # Retrieve customer info from Stripe
    customer = Stripe::Customer.retrieve(customer_id)
    
    if customer.cards.count > 0
      # Retrieve existing default card and delete it
      existing_card = customer.cards.retrieve(customer.default_card)
      customer.cards.retrieve(existing_card.id).delete
    end
    
    # Add new card and set as default
    new_card = customer.cards.create(card: token)
    customer.default_card = new_card.id
    
    # Update user info in database
    self.last_4_digits = customer.cards.retrieve(customer.default_card).last4
    self.stripe_card_token = nil
    self.save
  end
    

  def cancel_plan
    unless plan.blank? || (plan == "stacksocial")
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.first.try(:delete, at_period_end: true)
      
      # Send confirmation email to user
      UserMailer.subscription_cancelled(email, name).deliver

      # Send Susie email notification
      UserMailer.unsubscribe(name, email, plan).deliver
    end
  end

private

  def delete_subscription
    if self.plan.present? && (self.plan != "stacksocial")
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.first.delete()
    end
  end
end