require 'json'
require 'open-uri'
require 'wikipedia'

class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
    # 選ばないといけない
    # select_website (service file)
    if @website.name == "The New York Times"
      @website.datetime = DateTime.now
      url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{@website.keyword}&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"
      ny_serialized = open(url1).read
      @keyword_articles = JSON.parse(ny_serialized)
    elsif @website.name == "Financial Times"
      url2 = "https://api.ft.com/content/notifications?apiKey=59cbaf20e3e06d3565778e7b7b9ba4f2d4ed4887b6861c77c7eda766&since=#{@website.datetime}"
      # DateTime.now or Time.nowを別のクラスに直さないといけない　ももとやったやつ
      # 2020-06-12T13:50:00.000Z
      ft_serialized = open(url2).read
      @recent_articles = JSON.parse(ft_serialized)
    elsif @website.name == "Wikipedia"
      @page = Wikipedia.find(@website.keyword)
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
    params.require(:website).permit(:keyword, :datetime)
  end
end
