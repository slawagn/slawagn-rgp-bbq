class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event
  
  validates :event, presence: true
  validates :body, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
end
