class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name  = subscription.user_name
    @event = event

    mail to: event.user.email,
      subject: I18n.t('event_mailer.subscription.new_subscription') + event.title
  end

  def comment(event, comment, email)
    @comment = comment
    @event   = event

    mail to: email,
      subject: I18n.t('event_mailer.comment.new_comment') + event.title
  end
end
