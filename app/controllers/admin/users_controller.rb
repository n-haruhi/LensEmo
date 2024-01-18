class Admin::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user = admin_user
    if user.update(user_params)
      redirect_to admin_user_path, notice: "更新成功しました。"
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :username, :email, :introduction)
  end

end
