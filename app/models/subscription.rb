class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  scope :persisted, -> { where.not(id: nil) }

  with_options unless: -> { user.present? } do
    validates :user_email,
      presence: true,
      format:   URI::MailTo::EMAIL_REGEXP

    validates :user_email,
      uniqueness: { scope: :event_id }

    validate :using_email_of_existing_user
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

  def using_email_of_existing_user
    if User.exists?(email: user_email.downcase)
      errors.add(:user_email, :using_email_of_existing_user)
    end
  end
end
