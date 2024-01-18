class Public::UsersController < ApplicationController

  def show
    # @user = User.find(current_user.id)
    @user = current_user
  end

  def edit
    # @user = User.find(params[:id])
    @user = current_user
  end

  def update
    user = User.find(params[:id])
    user = current_user
    if user.update(user_params)
      redirect_to users_mypage_path(current_user), notice: "更新成功しました。" # 自身のマイページ(show)へ
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :username, :email, :introduction)
  end

end