class Public::PostsController < ApplicationController
  def index
    # データベースのpostsテーブルに保存されている全てのデータを取得
    @posts = Post.all
  end

  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @post = Post.new
  end

  def create
    # データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(post.id), notice: "投稿成功しました。"
    else
      @posts = Post.all
      render 'index'
    end
  end

  def show
    #postsテーブルの中にあるidが〇〇のレコードを取得してくる
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, { emotion: [] }, :body)
  end

end
