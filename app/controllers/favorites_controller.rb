class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(article_id: params[:article_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    @favorite.destroy
  end
end
