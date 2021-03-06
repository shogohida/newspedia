require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class CreateArticles

  def initialize
    @website = Website.find(params[:website_id])
  end

  def create
    # @articles = Article.includes(:likes).where(likes: { id: nil })
    # @articles.destroy_all
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
        content: @page.content,
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
      when "China" then @website.keyword = "cn"
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
      url3 = "https://newsapi.org/v2/top-headlines?country=#{@website.keyword}&apiKey=#{ENV['news_api_api_key']}"
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
        @website.keyword = word_array.join
      end
      url4 = "https://api.covid19api.com/total/country/#{@website.keyword}"
      covid_serialized = open(url4).read
      @covid_articles = JSON.parse(covid_serialized)
      article_number1 = 0
      @hash_confirmed = {}
      @hash_death = {}
      @hash_active = {}
      # @array_confirmed = []
      # @array_death = []
      # @array_active = []
      until article_number1 + 1 == @covid_articles.size
        if date_number1.zero?
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
end
