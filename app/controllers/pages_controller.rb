class PagesController < ApplicationController
  def home

    # Identify user and track 'Visit Homepage' event
    if user_signed_in?
      Analytics.identify(
        user_id: current_user.id,
        traits: {
          name: current_user.name,
          email: current_user.email,
          amount: current_user.amount
        }
      )
      Analytics.track(
        user_id: current_user.id,
        event: 'Visit Homepage',
        context: {
          'Google Analytics' => {
            clientId: '471240751.1390206154'
          }
        }
      )
    else
      # Analytics.identify(
      #   user_id: request.session_options[:id],
      # )
      Analytics.track(
        user_id: request.session_options[:id],
        event: 'Visit Homepage',
        context: {
          'Google Analytics' => {
            clientId: '471240751.1390206154'
          }
        }
      )
    end
  end

  def faq
  end

  def testimonial
  end

  def thanks
  end

  def courses
  end

  def marketplace
  end

  def about
  end
end
