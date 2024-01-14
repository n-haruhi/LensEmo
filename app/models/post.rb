class Post < ApplicationRecord
  # 関連付け
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # postsテーブルから中間テーブル
  has_many :post_tag_relations, dependent: :destroy
  # postsテーブルから中間テーブルを介してtagsテーブルへ
  has_many :tags, through: :post_tag_relations, dependent: :destroy
  # 通知機能: ポリモーフィック関連
  # Notificationモデルをnotifiableという名前で扱う
  has_many :notifications, as: :notifiable, dependent: :destroy

  # Active Storageの設定。投稿画像と気持ちを表す画像を用いる。
  has_one_attached :post_image
  has_one_attached :emotion_image

  # 引数で渡されたユーザidがFavoritesテーブル内に存在するかどうかを調べtrueかfalseを返す
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # データベースへの保存処理の実行後に処理実行
  # Postモデルのレコード作成に合わせてPost投稿者のフォロワーを取得し、
  # eachメソッドでそれぞれに対して通知を作成
  after_create do
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable_type: "Post", notifiable_id: id)
    end
  end

end
