class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options unless: -> { user.present? } do
    validates :user_email,
      presence: true,
      format:   URI::MailTo::EMAIL_REGEXP

    validates :user_email,
      uniqueness: { scope: :event_id }
  end

  with_options if: -> { user.present? } do
    validates :user,
      uniqueness: { scope: :event_id }

    validate :subscribing_to_own_event
  end

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
