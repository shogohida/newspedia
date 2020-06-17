class User < ApplicationRecord
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
end

# Install FactoryBot

# require 'rails_helper'

# RSpec.describe User, type: :model do
#   it "姓、名、メール、パスワードがある場合、有効である" do
#     user = FactoryBot.build(:user)
#     expect(user).to be_valid
#       end

#   it "名がない場合、無効である" do
#     user = FactoryBot.build(:user, first_name: nil)
#     user.valid?
#     expect(user.errors[:first_name]).to include("can't be blank")
#   end

#   it "姓がない場合、無効である" do
#     user = FactoryBot.build(:user, family_name: nil)
#     user.valid?
#     expect(user.errors[:family_name]).to include("can't be blank")
#   end

#   it "メールアドレスがない場合、無効である"  do
#     user = FactoryBot.build(:user, email: nil)
#     user.valid?
#     expect(user.errors[:email]).to include("can't be blank")
#   end

#   it "重複したメールアドレスの場合、無効である" do
#     user1 = FactoryBot.create(:user)
#     user2 = FactoryBot.build(:user)
#     user2.valid?
#     expect(user2.errors[:email]).to include("has already been taken")
#   end

#   it "パスワードがない場合、無効である"
#     user = FactoryBot.build(:user)
#     user.valid?
#     expect(user.errors[:password]).to include("can't be blank")
#   end
# end

# require 'rails_helper'

# RSpec.describe User, type: :model do

#   it "姓、名、メール、パスワードがある場合、有効である" do
# 　　 # userのそれぞれのカラムに対して値を入れてオブジェクト化する
#     user = User.new(
#     first_name: "tarou",
#      last_name: "testman",
#      email: "testman@example.com",
#      password: "password",
#      )
#      # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
#      expect(user).to be_valid
#   end

#   it "名がない場合、無効である"
#   it "姓がない場合、無効である"
#   it "メールアドレスがない場合、無効である"
#   it "重複したメールアドレスの場合、無効である"
# 　it "パスワードがない場合、無効である"

# end
