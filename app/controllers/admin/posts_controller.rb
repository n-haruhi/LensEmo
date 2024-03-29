class Admin::PostsController < ApplicationController
  # admin権限をもつユーザーかどうか確認
  before_action :if_not_admin

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to '/admin/posts', notice: "投稿が削除されました。"
    end
  end

  private
  # admin権限をもつユーザー以外でアクションしようとするとトップページに遷移する
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

end
