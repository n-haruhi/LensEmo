class Public::PostsController < ApplicationController

  def index
    # データベースのpostsテーブルに保存されている全てのデータを取得
    @posts = Post.all.page(params[:page]).per(10)
    # タグのor検索
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        @posts += Tag.find_by(name: key).posts if value == "1"
      end
      @posts.uniq!
    end
  end

  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @post = Post.new
  end

  def create
    # データを受け取り新規登録するためのインスタンス作成
    @post = current_user.posts.new(post_params)
    @user = current_user
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿しました。"
    else
      render 'new'
    end
  end

  def show
    #postsテーブルの中にあるidが〇〇のレコードを取得してくる
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post.id), notice: "投稿が更新されました。"
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to '/posts', notice: "投稿が削除されました。"
    end
  end

  private

  def post_params
    # emotionとtag_idsは複数入ってくる可能性のあるものなので配列の形式で記述
    params.require(:post).permit(:title, { emotion: [] }, :body, :post_image, tag_ids: [])
  end

end