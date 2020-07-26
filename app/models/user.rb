class User < ApplicationRecord
  # after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable
  has_many :favorites
  has_many :likes
  has_many :favorited_articles, through: :favorites, source: :article
  has_many :liked_articles, through: :likes, source: :article
  has_one_attached :photo
  # validates :name, presence: true

  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end

  # test user
  def self.guest
    find_by(email: 'test@gmail.com')
  end

  # omniauth
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        # email:    User.dummy_email(auth),
        # password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
