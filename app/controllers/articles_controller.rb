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
    elsif @website.name == "Financial Times"
      @website.datetime = DateTime.now - 1
      # DateTime.now - 1 ??? daily news
      # 上書くとユーザーの入力リセットされるよ
      url2 = "https://api.ft.com/content/notifications?apiKey=59cbaf20e3e06d3565778e7b7b9ba4f2d4ed4887b6861c77c7eda766&since=#{@website.datetime}"
      # DateTime.now or Time.nowを別のクラスに直さないといけない　ももとやったやつ
      # 2020-06-12T13:50:00.000Z
      ft_serialized = open(url2).read
      @recent_articles = JSON.parse(ft_serialized)
      @recent_articles["notifications"].each do |article|
        # @array << article["lead_paragraph"]
        @article = Article.new(
          website: @website,
          url: article["apiUrl"][0..7] + article["apiUrl"][12..-1]
        )
        if @article.valid?
          @article.save
        end
      end
    elsif @website.name == "Wikipedia"
      @page = Wikipedia.find(@website.keyword)
      @article = Article.new(
        website: @website,
        content: @page.summary
      )
      if @article.valid?
        @article.save
      end
    elsif @website.name == "News API"
      @website.country = "jp"
      url3 = "https://newsapi.org/v2/top-headlines?country=#{@website.country}&apiKey=3370e2330c5145c8beababe2e2110742"
      news_api_serialized = open(url3).read
      @country_articles = JSON.parse(news_api_serialized)["articles"]
      @country_articles.each do |article|
        @article = Article.new(
          website: @website,
          name: article["title"],
          content: article["description"]
        )
        if @article.valid?
          @article.save
        end
      end
    end
    @articles = Article.where(website_id: @website.id)
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
