class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name  = subscription.user_name
    @event = subscription.event

    mail to: @event.user.email,
      subject: I18n.t('event_mailer.subscription.new_subscription', title: @event.title)
  end

  def comment(comment)
    @comment = comment
    @event = comment.event

    emails =
    (
      @event.subscriptions.map(&:user_email) +
      [@event.user.email] -
      [comment.user&.email]
    ).uniq

    mail to: emails,
      subject: I18n.t('event_mailer.comment.new_comment', title: @event.title)
  end

  def photo(photo, author)
    @photo  = photo

    recipients = [photo.event.user] + photo.event.subscribers
    recipients.reject! { |user| user == author }

    emails = recipients.map(&:email)

    mail to: emails,
      subject: I18n.t('event_mailer.photo.title', title: @photo.event.title)
  end
end
