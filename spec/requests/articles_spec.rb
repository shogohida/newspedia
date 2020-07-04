require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "#index" do
    # need to use before?? or let?
    context "article is saved" do
      it "is saved in db" do
        website = Website.new(name: "Yomiuri")
        article = Article.new(content: "法務大臣逮捕", website: website)
        expect(article).to be_valid
        # maybe this one, expect(article.save).to be_truthy
      end

      # これいらない気がする
      it "directs to article/index page" do
      end
    end

    context "article is not saved" do
      it "is not saved in db" do
        website = Website.new(name: "Yomiuri")
        article1 = Article.create(content: "法務大臣逮捕", website: website)
        article2 = Article.new(content: "法務大臣逮捕", website: website)
        article2.valid?
        expect(article2.errors[:content]).to include("has already been taken")
      end

      it "directs to article/index page" do
      end
    end
  end
end
