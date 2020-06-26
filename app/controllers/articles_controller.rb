require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class ArticlesController < ApplicationController
  def index
    # このやり方だとインデックス行くたびに作られるけどいいのか
    @articles = Article.includes(:likes).where(likes: { id: nil })
    # @saved_articles = Article.joins(:likes)
    # @articles = Article.all
    # @saved_articles.each do |article|
    #   @articles.find(article.id).destroy
    # end
    @articles.destroy_all
    # .where.... if .liked?とかにしないと全部消えちゃう
    @website = Website.find(params[:website_id])
    # ホームページで媒体の選択とキーワードもしくは日時等（媒体に合わせて）入力させる
    # どうやって上の表示させるのかな？・・・
    # 長くなるのでサービスを作る select_website file
    # choose a type of articles you want to read (1 keyword, 2 date, 3 language)

    if @website.name == "The New York Times"
      url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=#{ENV['ny_times_api_key']}"
      ny_serialized = open(url1).read
      @keyword_articles = JSON.parse(ny_serialized)
      # @array = []
      @keyword_articles["response"]["docs"].each do |article|
        # @array << article["lead_paragraph"]
        @article = Article.new(
          website: @website,
          name: article["headline"]["main"],
          content: article["abstract"],
          url: article["web_url"]
        )
        if @article.valid?
          @article.save
        end
      end
    elsif @website.name == "Financial Times"
      @website.datetime = DateTime.now - 1
      # DateTime.now - 1 ??? daily news
      # 上書くとユーザーの入力リセットされるよ
      url2 = "https://api.ft.com/content/notifications?apiKey=#{ENV['ft_api_key']}&since=#{@website.datetime}"
      # DateTime.now or Time.nowを別のクラスに直さないといけない　ももとやったやつ
      # 2020-06-12T13:50:00.000Z
      # t = Time.now
      # t.strftime("%FT%T%:z")?
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
      if @website.keyword == "Japan"
        @website.country = "jp"
      elsif @website.keyword == "United States"
        @website.country = "us"
      elsif @website.keyword == "Mexico"
        @website.country = "mx"
      elsif @website.keyword == "Brazil"
        @website.country = "br"
      elsif @website.keyword == "China"
        @website.country = "cn"
      elsif @website.keyword == "France"
        @website.country = "fr"
      elsif @website.keyword == "Germany"
        @website.country = "de"
      elsif @website.keyword == "India"
        @website.country = "in"
      elsif @website.keyword == "Russia"
        @website.country = "ru"
      elsif @website.keyword == "South Korea"
        @website.country = "kr"
      elsif @website.keyword == "United Kingdom"
        @website.country = "gb"
      elsif @website.keyword == "Australia"
        @website.country = "au"
      elsif @website.keyword == "UAE"
        @website.country = "ae"
      elsif @website.keyword == "Nigeria"
        @website.country = "ng"
      end
      url3 = "https://newsapi.org/v2/top-headlines?country=#{@website.country}&apiKey=#{ENV['news_api_api_key']}"
      news_api_serialized = open(url3).read
      @country_articles = JSON.parse(news_api_serialized)["articles"]
      @country_articles.each do |article|
        @article = Article.new(
          website: @website,
          name: article["title"],
          content: article["description"],
          url: article["url"]
        )
        if @article.valid?
          @article.save
        end
      end
    elsif @website.name == "COVID-19 Data"
      # if @website.keyword.split.length <= 1....
      url4 = "https://api.covid19api.com/total/country/#{@website.keyword}"
      covid_serialized = open(url4).read
      @covid_articles = JSON.parse(covid_serialized)
      @covid_articles.each do |article|
        @article = Article.new(
          website: @website,
          name: article["Confirmed"].to_i,
          content: article["Deaths"],
          date: article["Date"]
        )
        if @article.valid?
          @article.save
        end
      end
    end
    @articles = Article.where(website_id: @website.id).includes(:likes).where(likes: { id: nil })
    # @articles = Article.where(website_id: @website.id)
    # @search_photo = Unsplash::Photo.search("#{@website.keyword}")[0][:urls][:raw]
  end

  def show
    @article = Article.find(params[:id])
    @like = Like.new
    @favorite = Favorite.new
    # for AJAX
    # respond_to do |format|
    #   format.html
    #   format.json { render json: { article: @article } }
    # end
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
