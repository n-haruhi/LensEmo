class Admin::UsersController < ApplicationController
  # admin権限をもつユーザーかどうか確認
  before_action :if_not_admin

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts # 個人が投稿したものすべてを表示できる
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました。"
    else
      render 'edit'
    end
  end

  private
  # admin権限をもつユーザー以外でアクションしようとするとトップページに遷移する
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:avatar, :username, :email, :introduction)
  end

end