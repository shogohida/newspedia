class ArticlesController < ApplicationController
  def index
    # @articles = Article.all
    # 上のやついらないのか
    # if website.name == "nytimes"....
    # ホームページで媒体の選択とキーワードもしくは日時等（媒体に合わせて）入力させる
    # どうやって上の表示させるのかな？・・・
    # 長くなるのでサービスを作る
    # choose a type of articles you want to read (1 keyword, 2 date, 3 language)
    # url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{keyword}&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"

    # API key to env file

    # select_webstie
  end

  def show
    @article = Article.find(params[:id])
    @like = Like.new
    @favorite = Favorite.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    # データベースに保存するため
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    @article.save
  end

  private

  def article_params
    params.require(:article).permit(:website_id, :name, :date, :summary, :url, :content, :memo)
  end
end
