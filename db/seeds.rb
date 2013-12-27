# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Chapter.delete_all

User.create!( name:     "Alex Yang",
              email:    "admin@example.com",
              password: "!X0bi1e1",
              admin:    true)

Chapter.create!(  section:  "Get Up and Running",
                  title:    "Install Ruby on Rails")
Chapter.create!(  section:  "Get Up and Running",
                  title:    "Install a Text Editor")

Chapter.create!(  section:  "Create Our Website",
                  title:    "Create a New App")
Chapter.create!(  section:  "Create Our Website",
                  title:    "Add Our First Pages")
Chapter.create!(  section:  "Create Our Website",
                  title:    "Add Links")
Chapter.create!(  section:  "Create Our Website",
                  title:    "Add Listings")

Chapter.create!(  section:  "Add Front-End Design",
                  title:    "Install Bootstrap")
Chapter.create!(  section:  "Add Front-End Design",
                  title:    "Add a Navigation Bar")
Chapter.create!(  section:  "Add Front-End Design",
                  title:    "Simplify Our Code")
Chapter.create!(  section:  "Add Front-End Design",
                  title:    "Build Beautiful Forms")

Chapter.create!(  section:  "Save Our Progress",
                  title:    "Set Up Git and GitHub")
Chapter.create!(  section:  "Save Our Progress",
                  title:    "Save Our Code")

Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Install ImageMagick")
Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Install Paperclip")
Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Set Up Paperclip")
Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Use Bootstrap Thumbnails")
Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Add Extra CSS")
Chapter.create!(  section:  "Update Listings with Images",
                  title:    "Design a Page Layout")

Chapter.create!(  section:  "Add Users",
                  title:    "Install Devise")
Chapter.create!(  section:  "Add Users",
                  title:    "Customize Devise's Pages")
Chapter.create!(  section:  "Add Users",
                  title:    "Insert Conditional Links")
Chapter.create!(  section:  "Add Users",
                  title:    "Add Names to Users")
Chapter.create!(  section:  "Add Users",
                  title:    "Validate User Data")

Chapter.create!(  section:  "Connect Users to Listings",
                  title:    "Link Our Models Together")
Chapter.create!(  section:  "Connect Users to Listings",
                  title:    "Create a Private Feed")
Chapter.create!(  section:  "Connect Users to Listings",
                  title:    "Set User Permissions")

Chapter.create!(  section:  "Place Orders",
                  title:    "Create an Order Model")
Chapter.create!(  section:  "Place Orders",
                  title:    "Link Our Models Together")
Chapter.create!(  section:  "Place Orders",
                  title:    "Ensure Order Fields Set Correctly")

Chapter.create!(  section:  "Accept Payments",
                  title:    "Install Stripe")
Chapter.create!(  section:  "Accept Payments",
                  title:    "Set Up Stripe")
Chapter.create!(  section:  "Accept Payments",
                  title:    "Update Our Order Form")
Chapter.create!(  section:  "Accept Payments",
                  title:    "Verify Credit Cards")
Chapter.create!(  section:  "Accept Payments",
                  title:    "Charge Credit Cards")

Chapter.create!(  section:  "Deploy on Heroku",
                  title:    "Set Up Heroku")
Chapter.create!(  section:  "Deploy on Heroku",
                  title:    "Launch Our App")
Chapter.create!(  section:  "Deploy on Heroku",
                  title:    "Using a Custom Domain")