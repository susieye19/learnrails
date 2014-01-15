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
              email:    "alex@baserails.com",
              password: ENV["ALEX_PASSWORD"],
              admin:    true)

Chapter.create!(  section: "Get Up and Running", title: "Course Introduction", url: "//player.vimeo.com/video/84193363")
Chapter.create!(  section: "Get Up and Running", title: "Installation for Mac Users")
Chapter.create!(  section: "Get Up and Running", title: "Installation for Non-Mac Users")

Chapter.create!(  section: "Create Our Website", title: "Create a New App")
Chapter.create!(  section: "Create Our Website", title: "Add Our First Pages")
Chapter.create!(  section: "Create Our Website", title: "Add Links")
Chapter.create!(  section: "Create Our Website", title: "Add Listings")

Chapter.create!(  section: "Add Front-End Design", title: "Install Bootstrap")
Chapter.create!(  section: "Add Front-End Design", title: "Add a Navigation Bar")
Chapter.create!(  section: "Add Front-End Design", title: "Simplify Our Code")
Chapter.create!(  section: "Add Front-End Design", title: "Build Beautiful Forms")

Chapter.create!(  section: "Update Listings With Images", title: "Install Paperclip and ImageMagick")
Chapter.create!(  section: "Update Listings With Images", title: "Set Up Paperclip")
Chapter.create!(  section: "Update Listings With Images", title: "Design Page Layouts")
Chapter.create!(  section: "Update Listings With Images", title: "Add Custom CSS")

Chapter.create!(  section: "Save Our Progress", title: "Set Up GitHub")
Chapter.create!(  section: "Save Our Progress", title: "Commit Our Code to GitHub")
Chapter.create!(  section: "Save Our Progress", title: "Deploy On Heroku")

Chapter.create!(  section: "Host Images Online", title: "Set Up Dropbox")
Chapter.create!(  section: "Host Images Online", title: "Protect Our Account Data")
Chapter.create!(  section: "Host Images Online", title: "Configure Dropbox Settings")

Chapter.create!(  section: "Add Users", title: "Install Devise")
Chapter.create!(  section: "Add Users", title: "Insert Conditional Links")
Chapter.create!(  section: "Add Users", title: "Customize Devise Forms and Alerts")
Chapter.create!(  section: "Add Users", title: "Add Names to Users")
Chapter.create!(  section: "Add Users", title: "Validate User and Listing Data")

Chapter.create!(  section: "Connect Users to Listings", title: "Associate Listings With Users")
Chapter.create!(  section: "Connect Users to Listings", title: "Set User Permissions")
Chapter.create!(  section: "Connect Users to Listings", title: "Create a Seller Page")
Chapter.create!(  section: "Connect Users to Listings", title: "Redesign the Seller Page")
Chapter.create!(  section: "Connect Users to Listings", title: "Create a Homepage Banner")

Chapter.create!(  section: "Place Orders", title: "Link Orders, Listings, Users (Part 1)")
Chapter.create!(  section: "Place Orders", title: "Link Orders, Listings, Users (Part 2)")
Chapter.create!(  section: "Place Orders", title: "Create Order History Pages")
Chapter.create!(  section: "Place Orders", title: "Reorganize Order Links and URLs")

Chapter.create!(  section: "Accept Payments", title: "Set Up Stripe")
Chapter.create!(  section: "Accept Payments", title: "Add Credit Card Fields")
Chapter.create!(  section: "Accept Payments", title: "Verify Credit Card Data")
Chapter.create!(  section: "Accept Payments", title: "Charge Credit Cards")

Chapter.create!(  section: "Transfer Payments", title: "Collect Bank Account Info")
Chapter.create!(  section: "Transfer Payments", title: "Verify Bank Account Info")
Chapter.create!(  section: "Transfer Payments", title: "Transfer Funds")
Chapter.create!(  section: "Transfer Payments", title: "Course Summary")