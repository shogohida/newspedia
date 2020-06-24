class Article < ApplicationRecord
  belongs_to :website
  has_many :favorites
  has_many :likes
  has_many :favorite_users, through: :favorites, source: :user
  has_many :like_users, through: :likes, source: :user
  validates :content, uniqueness: true
  validates :name, uniqueness: true
end
