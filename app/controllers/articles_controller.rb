require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class ArticlesController < ApplicationController
  def index
    # このやり方だとインデックス行くたびに作られるけどいいのか
    @website = Website.find(params[:website_id])
    # 上のやついらないのか
    # if website.name == "nytimes"....
    # ホームページで媒体の選択とキーワードもしくは日時等（媒体に合わせて）入力させる
    # どうやって上の表示させるのかな？・・・
    # 長くなるのでサービスを作る
    # choose a type of articles you want to read (1 keyword, 2 date, 3 language)
    # url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{keyword}&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"

    # API key to env file

    # select_website

    if @website.name == "The New York Times"
      url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"
      ny_serialized = open(url1).read
      @keyword_articles = JSON.parse(ny_serialized)
      # @array = []
      @keyword_articles["response"]["docs"].each do |article|
        # @array << article["lead_paragraph"]
        @article = Article.new(
          website: @website,
          content: article["lead_paragraph"]
        )
        if @article.valid?
          @article.save
        end
      end

    end
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @like = Like.new
    @favorite = Favorite.new
  end

  def create
    @website = Website.find(params[:website_id])
    @article = Article.new(content: @array)
    @article.website = @website
    # @article.user_id = current_user.id
    @article.save
    # データベースに保存するため
    # raise
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    @article.save
  end

  private

  def article_params
    params.require(:article).permit(:website_id, :name, :date, :summary, :url, :content, :memo)
  end
end
