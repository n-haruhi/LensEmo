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
  has_one_attached :avatar
  has_one_attached :post_image
  has_one_attached :emotion_image

  # titleが存在すること, 30字以下であること
  validates :title, presence: true, length: { maximum: 30 }
  # 本文は400文字以下
  # validates :body, length: { maximum: 400 }

  # bodyかemotionどちらか一方必須。両方存在していても良い。以下に定義有。
  validate :require_either_emotion_or_body

  def get_avatar(width, height)
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      avatar.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    avatar.variant(resize_to_limit: [width, height]).processed
  end

    # 引数で渡されたユーザidがFavoritesテーブル内に存在するかどうかを調べtrueかfalseを返す
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  private

  # bodyが空、且つ、emotionも空ならエラーメッセージ=>両方空ならエラーというカスタムのバリデーション。
  def require_either_emotion_or_body
    if emotion.blank? && body.blank?
      errors.add(:base, "気持ちか内容どちらか一方は必須です。")
    end
  end

end
