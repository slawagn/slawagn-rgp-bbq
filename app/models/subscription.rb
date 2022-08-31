class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event,
    presence: true

  validates :user_email,
    presence: true,
    format:   URI::MailTo::EMAIL_REGEXP,
    unless:   -> { user.present? }

  validates :user,
    uniqueness: { scope: :event_id },
    if:         -> { user.present? }

  validates :user_email,
    uniqueness: { scope: :event_id },
    unless:     -> { user.present? }

  validate :subscribing_to_own_event

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def subscribing_to_own_event
    if event.user == user
      errors.add(:base, :subscribing_to_own_event)
    end
  end
end
