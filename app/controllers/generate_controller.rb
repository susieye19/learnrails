class GenerateController < ApplicationController
  def form
  end

  def thanks
    app_name = params["q1"]
    homepage = params["q2"]

    pages_array_with_homepage = [homepage]
    pages_array_without_homepage = Array.new
    unless params["q3"].blank?
      pages_array_with_homepage << params["q3"]
      pages_array_without_homepage << params["q3"]
    end
    unless params["q4"].blank?
      pages_array_with_homepage << params["q4"]
      pages_array_without_homepage << params["q4"]
    end

    browser = Watir::Browser.new :chrome
    view_context.login(browser)
    view_context.generate_controller(browser, "pages", pages_array_with_homepage, homepage)
    view_context.add_navbar(browser, app_name, pages_array_without_homepage)
    sleep(10)
    browser.close
  end
end
