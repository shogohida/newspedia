require 'json'
require 'open-uri'
require 'wikipedia'
require 'news-api'

class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
    # 選ばないといけない
    # select_website (service file)
    if @website.name == "The New York Times"
      url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"
      ny_serialized = open(url1).read
      @keyword_articles = JSON.parse(ny_serialized)
      @array = []
      @keyword_articles["response"]["docs"].each do |article|
        @array << article["lead_paragraph"]
      end
      # articleへのリンクを作らないといいねとかブックマークできない
    elsif @website.name == "Financial Times"
      @website.datetime = DateTime.now
      # DateTime.now - 1 ??? daily news
      # 上書くとユーザーの入力リセットされるよ
      url2 = "https://api.ft.com/content/notifications?apiKey=59cbaf20e3e06d3565778e7b7b9ba4f2d4ed4887b6861c77c7eda766&since=#{@website.datetime}"
      # DateTime.now or Time.nowを別のクラスに直さないといけない　ももとやったやつ
      # 2020-06-12T13:50:00.000Z
      ft_serialized = open(url2).read
      @recent_articles = JSON.parse(ft_serialized)
    elsif @website.name == "Wikipedia"
      @page = Wikipedia.find(@website.keyword)
      # raise
    elsif @website.name == "News API"
      @website.country = "jp"
      url3 = "https://newsapi.org/v2/top-headlines?country=#{@website.country}&apiKey=3370e2330c5145c8beababe2e2110742"
      news_api_serialized = open(url3).read
      @country_articles = JSON.parse(news_api_serialized)["articles"]
      # n = News.new("3370e2330c5145c8beababe2e2110742")
      # @top_headlines = n.get_top_headlines(q: @website.keyword)
      # @everything = n.get_everything(q: "Trump")
      # sources: "the-mainichi"
      # raise
    end
  end

  def update
    @website = Website.find(params[:id])
    @website.update(website_params)
    redirect_to website_path(@website)
  end

  private

  def website_params
    params.require(:website).permit(:keyword, :datetime, :country)
  end
end
