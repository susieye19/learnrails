class GenerateController < ApplicationController
  def form
  end

  def thanks
    logger.info "Answer to Q1 was #{params["q1"]}"

    browser = Watir::Browser.new :chrome
    browser.goto "https://github.com/login"
    browser.text_field(:id, "login_field").set("alexyang.personal@gmail.com")
    browser.text_field(:id, "password").set("!X0bi1e1")
    browser.button(:class => 'button').click
    browser.goto "https://github.com/alexyang21/test020314"
  end
end
