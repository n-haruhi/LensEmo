class Public::ArticlesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page]).per(10)
  end

  def show
    @article = Article.find(params[:id])
  end
end
