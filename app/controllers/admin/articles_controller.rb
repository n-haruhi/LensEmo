class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_admin.article.new(article_params)
    if @article.save
      redirect_to admin_article_path(@article.id), notice: "投稿成功しました。"
    else
      render 'admin/articles/new'
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
    article.update(article_params)
    redirect_to article_path(article.id)
  end

  private

  def article_params
    params.require(:article).permit(:nickname, :title, :body, :article_image)
  end

end
