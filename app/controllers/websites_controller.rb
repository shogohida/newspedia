# require 'json'
# require 'open-uri'
# require 'wikipedia'
# require 'news-api'

class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])
    @website.update(website_params)
    redirect_to website_articles_path(@website)
  end

  private

  def website_params
    params.require(:website).permit(:keyword, :datetime, :country)
  end
end
