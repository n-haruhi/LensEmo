class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts # 個人が投稿したものすべてを表示できる
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "更新成功しました。" # 自身のマイページ(show)へ
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :username, :email, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end


end