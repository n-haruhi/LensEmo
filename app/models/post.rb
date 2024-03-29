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

  # titleが存在すること, 30字以下であること
  validates :title, presence: true, length: { maximum: 30 }
  # 本文は400文字以下
  # validates :body, length: { maximum: 400 }

  # bodyかemotionどちらか一方必須。両方存在していても良い。以下に定義有。
  validate :require_either_emotion_or_body

  # 感情の画像を条件で表示する
  def get_emotion_image
    case true
    when emotion.include?("anger") then
      "anger.png"
    when emotion.include?("disgust") then
      "disgust.png"
    when emotion.include?("fear") then
      "fear.png"
    when emotion.include?("sadness") then
      "sadness.png"
    when emotion.include?("anxiety") then
      "anxiety.png"
    when emotion.include?("calm") then
      "calm.png"
    when emotion.include?("hope") then
      "hope.png"
    when emotion.include?("joy") then
      "joy.png"
    when emotion.include?("love") then
      "love1.png"
    else
      "happiness.png"
    end
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
