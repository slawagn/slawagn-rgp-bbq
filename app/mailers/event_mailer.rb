class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name  = subscription.user_name
    @event = subscription.event

    mail to: @event.user.email, subject: default_i18n_subject(title: @event.title)
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: default_i18n_subject(title: @event.title)
  end

  def photo(photo, email)
    @photo  = photo

    mail to: email, subject: default_i18n_subject(title: @photo.event.title)
  end
end
