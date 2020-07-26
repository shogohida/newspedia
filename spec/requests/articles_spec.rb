require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:article) { FactoryBot.build(:article) }
  describe "#index" do
    # need to use before?? or let?
    context "article is saved" do
      it "is saved in db" do
        expect(article).to be_valid
        # maybe this one, expect(article.save).to be_truthy
      end

      it "directs to article/index page" do
      end
    end

    context "article is not saved" do
      it "is not saved in db" do
        article1 = FactoryBot.create(:article)
        # article = FactoryBot.build(:article)
        article.valid?
        expect(article.errors[:content]).to include("has already been taken")
      end

      it "directs to article/index page" do
      end
    end

    # context "invalid parameters" do
    #   it ""
  end
end
