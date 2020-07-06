class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(article_id: params[:article_id])
    @like.save
    respond_to do |format|
      format.html
      format.json { render json: { article: @article } }
    end
  end

  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.html
      format.json { render json: { article: @article } }
    end
  end
end
