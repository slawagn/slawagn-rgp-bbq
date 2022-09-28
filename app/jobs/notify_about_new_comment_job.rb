class NotifyAboutNewCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    emails =
    (
      comment.event.subscriptions.map(&:user_email) +
      [comment.event.user.email] -
      [comment.user&.email]
    ).uniq

    emails.each do |email|
      EventMailer.comment(comment, email).deliver_later
    end
  end
end
