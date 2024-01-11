class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.updateのshow(user_params)
    redirect_to user_path(user.id) # 自身のマイページ(show)へ
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :avatar)
  end

end