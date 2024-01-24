class Admin::TagsController < ApplicationController

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
    if @tag = Tag.find(params[:id])
      redirect_to admin_tags_path, notice: "タグを更新しました。"
    end
  end

  # 既存のタグを管理者が消してしまうのは良くないと思うので今回は作成しない。
  def destroy
  end

  def tag_params
    # tag_idsは複数入ってくる可能性のあるものなので配列の形式で記述
    params.require(:tag).permit(:name, tag_ids: [])
  end


end
