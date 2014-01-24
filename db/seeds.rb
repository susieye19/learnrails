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
Chapter.create!(  section: "Get Up and Running", title: "Installation for Mac Users", url: "//player.vimeo.com/video/84193364")
Chapter.create!(  section: "Get Up and Running", title: "Installation for Non-Mac Users", url: "//player.vimeo.com/video/84193365")

Chapter.create!(  section: "Create Our Website", title: "Create a New App", url: "//player.vimeo.com/video/84252033")
Chapter.create!(  section: "Create Our Website", title: "Add Our First Pages", url: "//player.vimeo.com/video/84249638")
Chapter.create!(  section: "Create Our Website", title: "Add Links", url: "//player.vimeo.com/video/84249635")
Chapter.create!(  section: "Create Our Website", title: "Add Listings", url: "//player.vimeo.com/video/84249636")

Chapter.create!(  section: "Add Front-End Design", title: "Install Bootstrap", url: "//player.vimeo.com/video/84822384")
Chapter.create!(  section: "Add Front-End Design", title: "Add a Navigation Bar", url: "//player.vimeo.com/video/84832051")
Chapter.create!(  section: "Add Front-End Design", title: "Simplify Our Code", url: "//player.vimeo.com/video/84252037")
Chapter.create!(  section: "Add Front-End Design", title: "Build Beautiful Forms", url: "//player.vimeo.com/video/84252038")

Chapter.create!(  section: "Update Listings With Images", title: "Install Paperclip and ImageMagick", url: "//player.vimeo.com/video/84253372")
Chapter.create!(  section: "Update Listings With Images", title: "Set Up Paperclip", url: "//player.vimeo.com/video/84253374")
Chapter.create!(  section: "Update Listings With Images", title: "Design Page Layouts", url: "//player.vimeo.com/video/84253375")
Chapter.create!(  section: "Update Listings With Images", title: "Add Custom CSS", url: "//player.vimeo.com/video/84253377")

Chapter.create!(  section: "Save Our Progress", title: "Set Up GitHub", url: "//player.vimeo.com/video/84253379")
Chapter.create!(  section: "Save Our Progress", title: "Commit Our Code to GitHub", url: "//player.vimeo.com/video/84254038")
Chapter.create!(  section: "Save Our Progress", title: "Deploy On Heroku", url: "//player.vimeo.com/video/84254039")

Chapter.create!(  section: "Host Images Online", title: "Set Up Dropbox", url: "//player.vimeo.com/video/84254040")
Chapter.create!(  section: "Host Images Online", title: "Protect Our Account Data", url: "//player.vimeo.com/video/84254041")
Chapter.create!(  section: "Host Images Online", title: "Configure Dropbox Settings", url: "//player.vimeo.com/video/84254045")

Chapter.create!(  section: "Add Users", title: "Install Devise", url: "//player.vimeo.com/video/84259232")
Chapter.create!(  section: "Add Users", title: "Insert Conditional Links", url: "//player.vimeo.com/video/84259235")
Chapter.create!(  section: "Add Users", title: "Customize Devise Forms and Alerts", url: "//player.vimeo.com/video/84259236")
Chapter.create!(  section: "Add Users", title: "Add Names to Users", url: "//player.vimeo.com/video/84259238")
Chapter.create!(  section: "Add Users", title: "Validate User and Listing Data", url: "//player.vimeo.com/video/84259239")

Chapter.create!(  section: "Connect Users to Listings", title: "Associate Listings With Users", url: "//player.vimeo.com/video/84259328")
Chapter.create!(  section: "Connect Users to Listings", title: "Set User Permissions", url: "//player.vimeo.com/video/84259329")
Chapter.create!(  section: "Connect Users to Listings", title: "Create a Seller Page", url: "//player.vimeo.com/video/84259330")
Chapter.create!(  section: "Connect Users to Listings", title: "Redesign the Seller Page", url: "//player.vimeo.com/video/84259331")
Chapter.create!(  section: "Connect Users to Listings", title: "Create a Homepage Banner", url: "//player.vimeo.com/video/84259336")

Chapter.create!(  section: "Place Orders", title: "Link Orders, Listings, Users (Part 1)", url: "//player.vimeo.com/video/84262523")
Chapter.create!(  section: "Place Orders", title: "Link Orders, Listings, Users (Part 2)", url: "//player.vimeo.com/video/84262524")
Chapter.create!(  section: "Place Orders", title: "Create Order History Pages", url: "//player.vimeo.com/video/84262526")
Chapter.create!(  section: "Place Orders", title: "Reorganize Order Links and URLs", url: "//player.vimeo.com/video/84262530")

Chapter.create!(  section: "Accept Payments", title: "Set Up Stripe", url: "//player.vimeo.com/video/84262532")
Chapter.create!(  section: "Accept Payments", title: "Add Credit Card Fields", url: "//player.vimeo.com/video/84262607")
Chapter.create!(  section: "Accept Payments", title: "Verify Credit Card Data", url: "//player.vimeo.com/video/84262608")
Chapter.create!(  section: "Accept Payments", title: "Charge Credit Cards", url: "//player.vimeo.com/video/84262609")

Chapter.create!(  section: "Transfer Payments", title: "Collect Bank Account Info", url: "//player.vimeo.com/video/84267009")
Chapter.create!(  section: "Transfer Payments", title: "Verify Bank Account Info", url: "//player.vimeo.com/video/84262610")
Chapter.create!(  section: "Transfer Payments", title: "Transfer Funds", url: "//player.vimeo.com/video/84265606")
Chapter.create!(  section: "Transfer Payments", title: "Course Summary", url: "//player.vimeo.com/video/84265607")