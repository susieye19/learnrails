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
    redirect_to marketplace_path, status: 301
  end

  def about
  end

  def thanks
  end

  def dashboard
  end

  def studentprojects
  end

  def pricing
  end

  def marketplace
  end

  def reviewapp
  end

  def webscraper
  end

  def apiscraper
  end
end
