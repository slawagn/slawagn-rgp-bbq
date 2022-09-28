class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  
  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.find_for_github_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = access_token.extra.raw_info.html_url 

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end   
  end

  def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def link_subscriptions
    Subscription
      .where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end

  def set_name
    self.name = "Господин №#{User.maximum(:id).to_i.next}" if self.name.blank?
  end
end
