# test memo
# Wikipedia, 100% exact
# FT, time must be before Time.now
# for all,
RSpec.describe Article do
  describe '#index' do
    # need to use before?? or let?
    context "@article is saved" do

      it "@article is saved in db" do
        expect(article.save).to be_truthy
        # maybe this one, expect(article.save).to be_truthy
      end

      # これいらない気がする
      it "directs to article/index page" do
      end

    end

    context "@article is not saved" do

      it "@article is not saved in db" do
        expect(article.save).to be_falthy
      end

      it "directs to article/index page" do
      end
    end
  end
end
