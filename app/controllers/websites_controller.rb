require 'json'
require 'open-uri'

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
      # keyword_articles["response"]["docs"].each do |article|
      #   puts article["lead_paragraph"]
      # end
      #   Event.create!(
      #     name: "test",
      #     user: @shogo,
      #     content: article["lead_paragraph"]
      #   )
      # end
    end
    # raise
  end

  def update
    @website = Website.find(params[:id])
    @website.update(website_params)
    redirect_to website_path(@website)
  end

  private

  def website_params
    params.require(:website).permit(:keyword)
  end
end
