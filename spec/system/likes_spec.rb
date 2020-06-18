require 'rails_helper'

RSpec.describe Like, type: :system do
  it "a like is valid if it belongs to a user and an article" do
    user = FactoryBot.build(:user)
    article = FactoryBot.build(:article)
    like = Like.new(user: user, article: article)
    expect(like).to be_valid
  end

  it "a like is invalid if it doesn't belong to an article" do
    user = FactoryBot.build(:user)
    # article = FactoryBot.build(:article)
    like = Like.new(user: user)
    like.valid?
    expect(like.errors[:article]).to include("Article must exist")
  end

  it "a like is invalid if it doesn't belong to a user" do
    # user = FactoryBot.build(:user)
    article = FactoryBot.build(:article)
    like = Like.new(article: article)
    like.valid?
    expect(like.errors[:user]).to include("User must exist")
  end
end
