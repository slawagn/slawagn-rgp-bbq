class NotifyAboutNewPhotoJob < ApplicationJob
  queue_as :default

  def perform(photo)
    recipients = [photo.event.user] + photo.event.subscribers
    recipients.reject! { |user| user == photo.user }

    emails = recipients.map(&:email)

    emails.each do |email|
      EventMailer.photo(photo, email).deliver_later
    end
  end
end
