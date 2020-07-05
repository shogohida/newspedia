require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:likes).where(likes: { id: nil })
    @articles.destroy_all
    @website = Website.find(params[:website_id])
    # @articles = CreateArticles.new
    # @articles = Article.where(website_id: @website.id).includes(:likes).where(likes: { id: nil })

    if @website.name == "The New York Times"
      nytimes_url = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=#{ENV['ny_times_api_key']}"
      nytimes_serialized = open(nytimes_url).read
      @keyword_articles = JSON.parse(nytimes_serialized)
      @keyword_articles["response"]["docs"].each do |article|
        @article = Article.new(
          website: @website,
          name: article["headline"]["main"],
          summary: article["abstract"],
          content: article["lead_paragraph"],
          url: article["web_url"]
          # image: "https://www.nytimes.com/" + article["multimedia"][0]["url"]
        )
        unless article["multimedia"].nil?
          @article.update(image: "https://www.nytimes.com/" + article["multimedia"][0]["url"])
        end
        @article.valid? ? @article.save : @article
      end
    elsif @website.name == "Wikipedia"
      @page = Wikipedia.find(@website.keyword)
      @article = Article.new(
        website: @website,
        name: @page.title,
        content: @page.summary,
        summary: @page.summary,
        url: @page.fullurl,
        image: @page.main_image_url
      )
      @article.valid? ? @article.save : @article
    elsif @website.name == "News API"
      case @website.keyword
      when "Japan" then @website.keyword = "jp"
      when "United States" then @website.keyword = "us"
      when "Mexico" then @website.keyword = "mx"
      when "Brazil" then @website.keyword = "br"
      when "Argentina" then @website.keyword = "ar"
      when "Colombia" then @website.keyword = "co"
      when "France" then @website.keyword = "fr"
      when "Germany" then @website.keyword = "de"
      when "India" then @website.keyword = "in"
      when "Russia" then @website.keyword = "ru"
      when "South Korea" then @website.keyword = "kr"
      when "United Kingdom" then @website.keyword = "gb"
      when "Australia" then @website.keyword = "au"
      when "UAE" then @website.keyword = "ae"
      when "Nigeria" then @website.keyword = "ng"
      when "Canada" then @website.keyword = "ca"
      when "Turkey" then @website.keyword = "tr"
      when "Poland" then @website.keyword = "pl"
      when "Malaysia" then @website.keyword = "my"
      when "Philippines" then @website.keyword = "ph"
      when "Ukraine" then @website.keyword = "ua"
      end
      news_api_url = "https://newsapi.org/v2/top-headlines?country=#{@website.keyword}&apiKey=#{ENV['news_api_api_key']}"
      news_api_serialized = open(news_api_url).read
      @country_articles = JSON.parse(news_api_serialized)["articles"]
      @country_articles.each do |article|
        if @website.keyword == "jp" || @website.keyword == "ru" || @website.keyword == "kr" || @website.keyword == "ae" || @website.keyword == "ua"
          @article = Article.new(
            website: @website,
            name: article["title"],
            summary: article["description"],
            content: article["description"],
            url: article["url"],
            image: article["urlToImage"]
          )
        else
          @article = Article.new(
            website: @website,
            name: article["title"],
            summary: article["description"],
            content: article["content"],
            url: article["url"],
            image: article["urlToImage"]
          )
        end
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
        @website.keyword = word_array.join
      end
      covid_url = "https://api.covid19api.com/total/country/#{@website.keyword}"
      # url4 = "https://api.covid19api.com/live/country/#{@website.keyword}/status/confirmed/date/2020-04-01T00:00:00Z"
      # covid_url = "https://api.covid19api.com/country/#{@website.keyword}?from=2020-04-01T00:00:00Z&to=2020-07-01T00:00:00Z"
      covid_serialized = open(covid_url).read
      @covid_articles = JSON.parse(covid_serialized)
      article_number1 = 0
      @hash_confirmed = {}
      @hash_death = {}
      @hash_active = {}
      # @array_confirmed = []
      # @array_death = []
      # @array_active = []
      until article_number1 + 1 == @covid_articles.size
        if article_number1.zero?
          @hash_confirmed[@covid_articles[article_number1]["Date"]] = @covid_articles[article_number1]["Confirmed"].to_i
          @hash_death[@covid_articles[article_number1]["Date"]] = @covid_articles[article_number1]["Deaths"].to_i
          # @array_confirmed << @covid_articles[date_number]["Confirmed"].to_i
          # @array_death << @covid_articles[date_number]["Deaths"].to_i
          # elsif @covid_articles[date_number]["Deaths"].to_i < @covid_articles[date_number - 1]["Deaths"].to_i || @covid_articles[date_number]["Confirmed"].to_i < @covid_articles[date_number - 1]["Confirmed"].to_i
        elsif @covid_articles[article_number1]["Deaths"].to_i > @covid_articles[article_number1 - 1]["Deaths"].to_i && @covid_articles[article_number1]["Confirmed"].to_i > @covid_articles[article_number1 - 1]["Confirmed"].to_i && @covid_articles[article_number1 - 1]["Deaths"].to_i != 0 && @covid_articles[article_number1]["Deaths"].to_i - 10000 < @covid_articles[article_number1 - 1]["Deaths"].to_i && @covid_articles[article_number1]["Confirmed"].to_i - 10000 < @covid_articles[article_number1 - 1]["Confirmed"].to_i
          @hash_confirmed[@covid_articles[article_number1]["Date"]] = @covid_articles[article_number1]["Confirmed"].to_i - @covid_articles[article_number1 - 1]["Confirmed"].to_i
          @hash_death[@covid_articles[article_number1]["Date"]] = @covid_articles[article_number1]["Deaths"].to_i - @covid_articles[article_number1 - 1]["Deaths"].to_i
          # @array_confirmed << @covid_articles[date_number]["Confirmed"].to_i - @covid_articles[date_number - 1]["Confirmed"].to_i
          # @array_death << @covid_articles[date_number]["Deaths"].to_i - @covid_articles[date_number - 1]["Deaths"].to_i
        end
        # @covid_articles[date_number - 1]["Confirmed"].to_i != 0
        # || @covid_articles[date_number]["Deaths"].to_i == 0 || @covid_articles[date_number]["Confirmed"].to_i == 0
        article_number1 += 1
      end
      # date_number2 = 0
      @covid_articles.each do |article|
        # until date_number2 + 1 == @covid_articles.size
        # if date_number2.zero?
        #   @hash_active[article["Date"]] = article["Active"].to_i
        if article["Date"] != "2020-06-24T00:00:00Z"
          # && @covid_articles[date_number2]["Active"].to_i + 10000 > @covid_articles[date_number2 - 1]["Active"].to_i
          @hash_active[article["Date"]] = article["Active"].to_i
          # @array_active << article["Active"].to_i
          # @excluded = Savanna::Outliers.remove_outliers(@array_active, :all)
          # ハッシュじゃないとグラフ作れないよ
        end
        # date_number2 += 1
        # end
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

  private

  def article_params
    params.require(:article).permit(:website_id, :name, :date, :summary, :url, :content, :memo)
  end
end
