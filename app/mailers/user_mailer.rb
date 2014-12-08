class UserMailer < ActionMailer::Base
  default from: "BaseRails <alex@baserails.com>"

  # USER NOTIFICATIONS
  # Someone replies to a user's comment
  def comment_reply_notification(recipient_email, recipient_name, commenter_name, body, url)
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    @recipient_name = recipient_name
    @commenter_name = commenter_name
    @body = body
    @url = url

    mail to: email_with_name, subject: "#{commenter_name} replied to your comment on BaseRails"
  end
  
  # Invoice payment failed
  def invoice_payment_failed(recipient_email, recipient_name)
    @recipient_name = recipient_name
    
    # Email user
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "BaseRails payment failed"
    
    # Email Susie
    mail to: "Susie Ye <susie@baserails.com>", subject: "Automatic unsubscribe: #{recipient_email}"
  end
  
  # Access ended
  def access_ended(recipient_email, recipient_name)
    @recipient_name = recipient_name
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "Your BaseRails access has ended"
  end
  
  # Subscription cancelled
  def subscription_cancelled(recipient_email, recipient_name)
    @recipient_name = recipient_name
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "BaseRails subscription cancelled"
  end
  
  

  # ALEX NOTIFICATIONS
  # New comment is posted
  def new_comment(commenter_name, body, url)
    @commenter_name = commenter_name
    @body = body
    @url = url

    mail  to: "Alex Yang <alexyang.personal@gmail.com>",
          from: "BaseRails <notifications@baserails.com>",
          subject: "#{commenter_name} posted a new comment on BaseRails"
  end

  # New question is asked
  def question_notification(asker, subject, details)
    @asker = asker
    @subject = subject
    @details = details

    mail  to: "Alex Yang <alexyang.personal@gmail.com>",
          from: "BaseRails <notifications@baserails.com>",
          subject: "#{asker} posted a new question on BaseRails"
  end

  # SUSIE NOTIFICATIONS
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

  # Free user converts to paid subscription
  def convert_to_paid(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Susie Ye <susie@baserails.com>", subject: "Convert to #{plan}: #{email}"
  end

  # User manually changes subscription plan
  def edit_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Susie Ye <susie@baserails.com>", subject: "Subscription changed to #{plan}"
  end

  # User manually cancelled subscription
  def unsubscribe(user_name, email, plan)
    @user_name = user_name
    @plan = plan
    @email = email

    mail to: "Susie Ye <susie@baserails.com>", subject: "#{user_name} unsubscribed from the #{plan} plan"
  end
end