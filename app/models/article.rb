class Article < ApplicationRecord
  belongs_to :website
  has_many :favorites
  has_many :likes
  has_many :favorited_users, through: :favorites, source: :user
  has_many :liked_users, through: :likes, source: :user
end
