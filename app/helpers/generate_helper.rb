module GenerateHelper
  def login(browser)
    browser.goto "https://github.com/login"
    browser.text_field(:id, "login_field").set("alexyang.personal@gmail.com")
    browser.text_field(:id, "password").set(ENV["ALEX_PASSWORD"])
    browser.button(:class => 'button').click
    browser.goto "https://github.com/alexyang21/typecast"
  end

  def navigate(browser, path)
    sections = path.split('/')
    sections.each do |section|
      browser.link(:title, section).click
      sleep(1)
    end
  end

  def new_file(browser, path)
    # Create new file and go to edit screen
    browser.span(:class, "js-new-blob-submit octicon octicon-file-add").click
    browser.text_field(:class, "filename").set(path)
    browser.span(:class, "octicon octicon-screen-full").click
  end

  def edit_file(browser, path)
    # Navigate to existing file and go to edit screen
    navigate(browser, path)
    browser.link(:text, "Edit").click
    browser.span(:class, "octicon octicon-screen-full").click
  end

  def save_file(browser, path)
    # Exit edit screen, submit change, and return to repository
    browser.span(:class, "mega-octicon octicon-screen-normal").click
    browser.button(:id, "submit-file").click
    browser.goto "https://github.com/alexyang21/test020314"
  end

  def delete_file(browser, path)
    # Navigate to file
    navigate(browser, path)

    # Delete file and return to repository
    browser.link(:class, "minibutton danger empty-icon tooltipped downwards").click
    browser.button(:id, "submit-file").click
    browser.goto "https://github.com/alexyang21/test020314"
  end

  def copy_code(browser, file)
    File.open(file, "r") do |f|
      f.each_line do |line|
        browser.text_field(:id, "fullscreen-contents").append(line)
      end
    end
  end

  # def set_root(browser, controller_name, page)
  #   edit_file(browser, "config/routes.rb")

  #   # Edit code
  #   contents = browser.text_field(:id, "fullscreen-contents").value.lines
  #   browser.text_field(:id, "fullscreen-contents").set("")
  #   contents.each_with_index do |line, index|
  #     if index == 1
  #       browser.text_field(:id, "fullscreen-contents").append("root '#{controller_name}##{page}'\n")
  #     end
  #     browser.text_field(:id, "fullscreen-contents").append(line)
  #   end

  #   save_file(browser, "config/routes.rb")
  # end




  # Generate pages_controller
  def create_controller(browser, controller_name, pages_array)
    path = "app/controllers/#{controller_name}_controller.rb"
    new_file(browser, path)

    # Write code
    browser.text_field(:id, "fullscreen-contents").append("class PagesController < ApplicationController\n")
    pages_array.each_with_index do |page, index|
      browser.text_field(:id, "fullscreen-contents").append("  def #{page.downcase}\n")
      browser.text_field(:id, "fullscreen-contents").append("  end\n")
      unless index == (pages_array.length - 1)
        browser.text_field(:id, "fullscreen-contents").append("\n")
      end
    end
    browser.text_field(:id, "fullscreen-contents").append("end")

    save_file(browser, path)
  end

  # Generate view page
  def views(browser, controller_name, pages_array)
    pages_array.each do |page|
      path = "app/views/#{controller_name}/#{page.downcase}.html.erb"

      new_file(browser, path)

      # Write code
      browser.text_field(:id, "fullscreen-contents").append("<h1>Pages##{page.downcase}</h1>\n")
      browser.text_field(:id, "fullscreen-contents").append("<p>Find me in app/views/pages/#{page.downcase}.html.erb</p>")

      save_file(browser, path)
    end
  end

  # Add route
  def add_route(browser, controller_name, pages_array, homepage)
    edit_file(browser, "config/routes.rb")

    # Edit code
    browser.text_field(:id, "fullscreen-contents").set("")
    browser.text_field(:id, "fullscreen-contents").append("Test020314::Application.routes.draw do\n")

    pages_array.each do |page|
      browser.text_field(:id, "fullscreen-contents").append("  get '#{page.downcase}' => '#{controller_name}##{page.downcase}'\n")
    end
    browser.text_field(:id, "fullscreen-contents").append("  root '#{controller_name}##{homepage.downcase}'\n")
    browser.text_field(:id, "fullscreen-contents").append("end")

    # # Edit code
    # contents = browser.text_field(:id, "fullscreen-contents").value.lines
    # browser.text_field(:id, "fullscreen-contents").set("")
    # contents.each_with_index do |line, index|
    #   if index == 1
    #     pages_array.each do |page|
    #       browser.text_field(:id, "fullscreen-contents").append("get '#{page.downcase}' => '#{controller_name}##{page.downcase}'\n")
    #     end
    #     browser.text_field(:id, "fullscreen-contents").append("root '#{controller_name}##{homepage.downcase}'\n")
    #   end
    #   browser.text_field(:id, "fullscreen-contents").append(line)
    # end

    save_file(browser, "config/routes.rb")
  end

  # Rails generate controller
  def generate_controller(browser, controller_name, pages_array, homepage)
    create_controller(browser, controller_name, pages_array)
    views(browser, controller_name, pages_array)
    add_route(browser, controller_name, pages_array, homepage)
  end

  def add_navbar(browser, app_name, pages_array)
    edit_file(browser, "app/views/layouts/application.html.erb")

    # Edit code
    contents = browser.text_field(:id, "fullscreen-contents").value.lines
    browser.text_field(:id, "fullscreen-contents").set("")
    contents.each_with_index do |line, index|

      if line.chomp == "<%= yield %>"
        browser.text_field(:id, "fullscreen-contents").append(%Q[<div class="container">\n])
        browser.text_field(:id, "fullscreen-contents").append(%Q[  <%= yield %>\n])
        browser.text_field(:id, "fullscreen-contents").append(%Q[</div>\n])
      else
        browser.text_field(:id, "fullscreen-contents").append(line)
      end

      if line.chomp == "<body>"
        File.open(Rails.root.join('app','views','navbar.html.erb'), "r") do |f|
          f.each_line do |navbar_line|

            if navbar_line.chomp == '      <a class="navbar-brand" href="#">Brand</a>'
              browser.text_field(:id, "fullscreen-contents").append(%Q[      <a class="navbar-brand" href="/">#{app_name}</a>\n])

            elsif navbar_line.chomp == '        <li><a href="#">Link</a></li>'
              pages_array.each do |page|
                browser.text_field(:id, "fullscreen-contents").append(%Q[        <li><a href="/#{page.downcase}">#{page}</a></li>\n])
              end

            else
              browser.text_field(:id, "fullscreen-contents").append(navbar_line)
            end
          end
        end
        browser.text_field(:id, "fullscreen-contents").append("\n")
      end

    end

    save_file(browser, "app/views/layouts/application.html.erb")
  end
end
