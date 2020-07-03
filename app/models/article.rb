class Article < ApplicationRecord
  belongs_to :website
  has_many :favorites
  has_many :likes
  has_many :favorite_users, through: :favorites, source: :user
  has_many :like_users, through: :likes, source: :user
  validates :content, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
end
