class Admin::ArticlesController < ApplicationController
  # admin権限をもつユーザーかどうか確認
  before_action :if_not_admin

  def index
    @articles = Article.all.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
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
    if article.update(article_params)
      redirect_to article_path(article.id)
    else
      render 'edit'
    end
  end

  private
  # admin権限をもつユーザー以外でアクションしようとするとトップページに遷移する
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def article_params
    params.require(:article).permit(:username, :title, :body, :article_image).merge(user_id: current_user.id)
  end

end
