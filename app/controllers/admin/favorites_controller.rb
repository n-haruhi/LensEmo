class Admin::FavoritesController < ApplicationController

  def show
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post_id)
    favorite.destroy
    redirect_to post_path(post)
  end
end
