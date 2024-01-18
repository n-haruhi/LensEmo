class Admin::HomesController < ApplicationController
  def top
    @articles = Article.all.page(params[:page]).per(10)
  end
end
