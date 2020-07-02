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
      @website.datetime = Time.now.strftime("%FT%T%:z")
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
      when "Canada" then @website.country = "ca"
      when "Turkey" then @website.country = "tr"
      when "Poland" then @website.country = "pl"
      when "Malaysia" then @website.country = "my"
      when "Philippines" then @website.country = "ph"
      when "Ukraine" then @website.country = "ua"
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
      word_index = 1
      word_array = @website.keyword.split(" ")
      if word_array.length >= 2
        until word_index == word_array.length
          word_array.insert(word_index, "-")
          word_index += 2
        end
        # index[1] insert -
        # case @website.keyword
        # when.....で場合分け?
        @website.keyword = word_array.join
      end
      url4 = "https://api.covid19api.com/total/country/#{@website.keyword}"
      covid_serialized = open(url4).read
      @covid_articles = JSON.parse(covid_serialized)
      date_number = 0
      @hash_confirmed = Hash.new
      @hash_death = Hash.new
      @hash_active = Hash.new
      # iteration for total number
      # @covid_articles.each do |article|
      #   @article = Article.new(
      #     website: @website,
      #     name: article["Confirmed"].to_i,
      #     content: article["Deaths"].to_i,
      #     date: article["Date"]
      #   )
      #   @article.valid? ? @article.save : @article
      # @hash_confirmed[article["Date"]] = article["Confirmed"].to_i
      # # .strftime("%a")
      # @hash_death[article["Date"]] = article["Deaths"].to_i
      until date_number + 1 == @covid_articles.size
        if date_number.zero?
          @hash_confirmed[@covid_articles[date_number]["Date"]] = @covid_articles[date_number]["Confirmed"].to_i
          @hash_death[@covid_articles[date_number]["Date"]] = @covid_articles[date_number]["Deaths"].to_i
          # elsif @covid_articles[date_number]["Deaths"].to_i < @covid_articles[date_number - 1]["Deaths"].to_i || @covid_articles[date_number]["Confirmed"].to_i < @covid_articles[date_number - 1]["Confirmed"].to_i
          #   date_number += 1
        elsif @covid_articles[date_number]["Deaths"].to_i > @covid_articles[date_number - 1]["Deaths"].to_i && @covid_articles[date_number]["Confirmed"].to_i > @covid_articles[date_number - 1]["Confirmed"].to_i && @covid_articles[date_number - 1]["Deaths"].to_i != 0
          @hash_confirmed[@covid_articles[date_number]["Date"]] = @covid_articles[date_number]["Confirmed"].to_i - @covid_articles[date_number - 1]["Confirmed"].to_i
          @hash_death[@covid_articles[date_number]["Date"]] = @covid_articles[date_number]["Deaths"].to_i - @covid_articles[date_number - 1]["Deaths"].to_i
        end
        # @covid_articles[date_number - 1]["Confirmed"].to_i != 0
        # || @covid_articles[date_number]["Deaths"].to_i == 0 || @covid_articles[date_number]["Confirmed"].to_i == 0
        date_number += 1
      end
      @covid_articles.each do |article|
        unless article["Date"] == "2020-06-24T00:00:00Z"
          @hash_active[article["Date"]] = article["Active"].to_i
        end
      end
    end
    @articles = Article.where(website_id: @website.id).includes(:likes).where(likes: { id: nil })
  end

  def show
    @article = Article.find(params[:id])
    @like = Like.new
    @favorite = Favorite.new
    # for AJAX
    respond_to do |format|
      format.html
      format.json { render json: { article: @article } }
    end
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
