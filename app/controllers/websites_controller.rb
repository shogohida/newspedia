class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end

  def show
    @website = Website.find(params[:id])
    # 選ばないといけない
    select_website
  end
end
