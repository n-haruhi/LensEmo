class Public::FavoritesController < ApplicationController

  def show
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorite.new(post_id: post_id)
    favorite.save
    redirect_to post_path(post)
  end

  def update
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post_id)
    favorite.destroy
    redirect_to post_path(post)
  end

end
