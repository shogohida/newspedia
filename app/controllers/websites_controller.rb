class WebsitesController < ApplicationController
  skip_before_action :authenticate_user!
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
