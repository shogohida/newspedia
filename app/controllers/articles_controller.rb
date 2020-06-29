require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class ArticlesController < ApplicationController
  def index
    # このやり方だとインデックス行くたびに作られるけどいいのか
    @articles = Article.includes(:likes).where(likes: { id: nil })
    @articles.destroy_all
    @website = Website.find(params[:website_id])
    # 長くなるのでサービスを作る select_website file
    if @website.name == "The New York Times"
      url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=#{ENV['ny_times_api_key']}"
      ny_serialized = open(url1).read
      @keyword_articles = JSON.parse(ny_serialized)
      @keyword_articles["response"]["docs"].each do |article|
        @article = Article.new(
          website: @website,
          name: article["headline"]["main"],
          summary: article["abstract"],
          content: article["lead_paragraph"],
          url: article["web_url"],
          # image: "https://www.nytimes.com/" + article["multimedia"][0]["url"]
        )
        unless article["multimedia"].nil?
          @article.update(image: "https://www.nytimes.com/" + article["multimedia"][0]["url"])
        end
        @article.valid? ? @article.save : @article
        # if @article.valid?
        #   @article.save
        # end
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
        @article = Article.new(
          website: @website,
          url: article["apiUrl"][0..7] + article["apiUrl"][12..-1]
        )
        @article.valid? ? @article.save : @article
      end
    elsif @website.name == "Wikipedia"
      @page = Wikipedia.find(@website.keyword)
      @article = Article.new(
        website: @website,
        name: @page.title,
        content: @page.content,
        summary: @page.summary,
        url: @page.fullurl,
        image: @page.main_image_url
      )
      @article.valid? ? @article.save : @article
    elsif @website.name == "News API"
      case @website.keyword
      when "Japan" then @website.country = "jp"
      when "United States" then @website.country = "us"
      when "Mexico" then @website.country = "mx"
      when "Brazil" then @website.country = "br"
      when "China" then @website.country = "cn"
      when "France" then @website.country = "fr"
      when "Germany" then @website.country = "de"
      when "India" then @website.country = "in"
      when "Russia" then @website.country = "ru"
      when "South Korea" then @website.country = "kr"
      when "United Kingdom" then @website.country = "gb"
      when "Australia" then @website.country = "au"
      when "UAE" then @website.country = "ae"
      when "Nigeria" then @website.country = "ng"
      end
      url3 = "https://newsapi.org/v2/top-headlines?country=#{@website.country}&apiKey=#{ENV['news_api_api_key']}"
      news_api_serialized = open(url3).read
      @country_articles = JSON.parse(news_api_serialized)["articles"]
      @country_articles.each do |article|
        @article = Article.new(
          website: @website,
          name: article["title"],
          summary: article["description"],
          content: article["content"],
          url: article["url"],
          image: article["urlToImage"]
        )
        @article.valid? ? @article.save : @article
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
        @article.valid? ? @article.save : @article
      end
    end
    @articles = Article.where(website_id: @website.id).includes(:likes).where(likes: { id: nil })
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

  # def create
  #   @website = Website.find(params[:website_id])
  #   @article = Article.new(content: @array)
  #   @article.website = @website
  #   # @article.user_id = current_user.id
  #   @article.save
  #   # データベースに保存するため
  #   # raise
  # end

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
