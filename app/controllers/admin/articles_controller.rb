class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_article_path(article.id), notice: "投稿成功しました。"
    else
      @article = Article.all
      render 'admin/articles'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    article.update(list_params)
    redirect_to article_path(article.id)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :article_image)
  end

end
