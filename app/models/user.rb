class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :likes
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :like_articles, through: :likes, source: :article
  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end
end
