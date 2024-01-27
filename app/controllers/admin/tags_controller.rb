class Admin::TagsController < ApplicationController
  # admin権限をもつユーザーかどうか確認
  before_action :if_not_admin

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tags = Tag.all
    if @tag.save
      redirect_to admin_tags_path, notice: "タグを追加しました。"
    else
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    @tags = Tag.all
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグを更新しました。"
    else
      render :edit
    end
  end


  private
  # admin権限をもつユーザー以外でアクションしようとするとトップページに遷移する
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def tag_params
    # tag_idsは複数入ってくる可能性のあるものなので配列の形式で記述
    params.require(:tag).permit(:name, tag_ids: [])
  end

end
