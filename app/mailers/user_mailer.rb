class UserMailer < ActionMailer::Base
  default from: "BaseRails <alex@baserails.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.comment_notification.subject
  #
  def comment_notification(recipient_email, recipient_name, commenter_name, body)
    @recipient_name = recipient_name
    @commenter_name = commenter_name
    @body = body
    email_with_name = "#{recipient_name} <#{recipient_email}>"

    mail to: email_with_name, subject: "#{commenter_name} replied to your comment on BaseRails"
  end

  def alex_notification(commenter_name, body)
    @commenter_name = commenter_name
    @body = body

    mail to: "Alex Yang <alexyang.personal@gmail.com>", subject: "#{commenter_name} posted a new comment on BaseRails"
  end
end