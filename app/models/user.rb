class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :likes
  has_many :favorited_articles, through: :favorites, source: :article
  has_many :liked_articles, through: :likes, source: :article
  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end
  has_one_attached :photo
  validates :name, presence: true

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
