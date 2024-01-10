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
    # データをデータベースに保存するためのsaveメソッドを実行
    @post.save
    # 投稿一覧画面へリダイレクト
    redirect_to posts_path
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
  # ストロングパラメータ
  def post_params
    # formから送られるデータをparamsの中に入れる
    # その中からrequireでモデル名を指定しデータを絞り込む。
    # 絞り込んだデータの中から保存を許可するカラムを指定。
    params.require(:post).permit(:title, :emotion, :body)
  end

end
