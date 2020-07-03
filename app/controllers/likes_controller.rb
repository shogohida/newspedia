class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(article_id: params[:article_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    @like.destroy
  end
end
