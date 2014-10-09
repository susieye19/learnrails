class UserMailer < ActionMailer::Base
  default from: "BaseRails <alex@baserails.com>"

  # USER NOTIFICATIONS
  # Notification email sent when someone replies to a user's comment
  def comment_reply_notification(recipient_email, recipient_name, commenter_name, body, url)
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    @recipient_name = recipient_name
    @commenter_name = commenter_name
    @body = body
    @url = url

    mail to: email_with_name, subject: "#{commenter_name} replied to your comment on BaseRails"
  end


  # ALEX NOTIFICATIONS
  # New comment is posted
  def new_comment(commenter_name, body, url)
    @commenter_name = commenter_name
    @body = body
    @url = url

    mail to: "Alex Yang <alexyang.personal@gmail.com>", subject: "#{commenter_name} posted a new comment on BaseRails"
  end

  # New question is asked
  def question_notification(asker, subject, details)
    @asker = asker
    @subject = subject
    @details = details

    mail to: "Alex Yang <alexyang.personal@gmail.com>", subject: "#{asker} posted a new question on BaseRails"
  end

  # New free membership is created
  def new_user(user_name, email)
    @user_name = user_name
    @email = email

    mail to: "Susie Ye <susie@baserails.com>", subject: "Free User: #{email}"
  end

  # New paid subscription is created
  def new_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Susie Ye <susie@baserails.com>", subject: "#{plan.capitalize} User: #{email}"
  end

  def convert_to_paid(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Susie Ye <susie@baserails.com>", subject: "Convert to #{plan}: #{email}"
  end

  def edit_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Susie Ye <susie@baserails.com>", subject: "Subscription changed to #{plan}"
  end

  # Alex's notification when an existing paid membership is cancelled
  def unsubscribe(user_name, email, plan)
    @user_name = user_name
    @plan = plan
    @email = email

    mail to: "Susie Ye <susie@baserails.com>", subject: "#{user_name} unsubscribed from the #{plan} plan"
  end
end