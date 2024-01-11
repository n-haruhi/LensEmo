class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    @post.user_id = current_user.id
    @user = current_user
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿成功しました。"
    else
      render :new, notice: "投稿できませんでした。"
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
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to '/posts'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, { emotion: [] }, :body, :post_image)
  end

end