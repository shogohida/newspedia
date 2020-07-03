require 'rails_helper'

RSpec.describe Article, type: :system do
  it "is valid if it has a name, content and url " do
    article = FactoryBot.build(:article)
    expect(article).to be_valid
  end

  it "is invalid if it doesn't have a name" do
    article = FactoryBot.build(:article, name: nil)
    article.valid?
    expect(article.errors[:name]).to include("can't be blank")
  end

  it "is invalid if it doesn't have a content" do
    article = FactoryBot.build(:article, content: nil)
    article.valid?
    expect(article.errors[:content]).to include("can't be blank")
  end

  it "is invalid if it doesn't have a url" do
    article = FactoryBot.build(:article, url: nil)
    article.valid?
    expect(article.errors[:url]).to include("can't be blank")
  end

  it "is invalid if its name is the same as another article" do
    article1 = FactoryBot.create(:article)
    article2 = FactoryBot.build(:article)
    article2.valid?
    expect(article2.errors[:name]).to include("is the same as another article")
  end

  it "is invalid if its content is the same as another article" do
    article1 = FactoryBot.create(:article)
    article2 = FactoryBot.build(:article)
    article2.valid?
    expect(article2.errors[:content]).to include("is the same as another article")
  end

  it "is invalid if its url is the same as another article" do
    article1 = FactoryBot.create(:article)
    article2 = FactoryBot.build(:article)
    article2.valid?
    expect(article2.errors[:url]).to include("is the same as another article")
  end

end
