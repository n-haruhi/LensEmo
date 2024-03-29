class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc)
    # タグのAND検索
    if params[:tag_ids] # 存在するならタグの検索
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1" # `value`が「1」である場合に検索を行う
          tag_posts = Tag.find_by(name: key).posts #`Tag`モデルから`name`が`key`と一致するタグを見つけ(`tag_posts`)を取得
          @posts = @posts.empty? ? tag_posts : @posts & tag_posts
          @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10) # 配列の場合のページネーション記述
        end
      end
    end
  end

  def new
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
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿が更新されました。"
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
    params.require(:post).permit(:title, :body, :emotion, :emotion_image, tag_ids: [])
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end