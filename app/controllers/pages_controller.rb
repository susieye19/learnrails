class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:cancel]

  # Static pages in front of the paywall
  def home
  end

  def faq
  end

  def testimonial
  end

  def syllabus
  end

  def about
  end

  def thanks
  end

  def dashboard
  end

  def stories
  end

  def pricing
  end

  # Pages for managing user subscriptions
  def cancel
    @user = current_user
    if @user.cancel_plan
      redirect_to subscribe_path, notice: "Your current plan has been cancelled"
    else
      redirect_to subscribe_path, notice: "Sorry, we were unable to cancel your plan"
    end
  end
end
