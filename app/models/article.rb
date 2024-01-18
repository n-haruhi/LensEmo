class Article < ApplicationRecord

  belongs_to :user
  # 通知機能: ポリモーフィック関連
  # Notificationモデルをnotifiableという名前で扱う
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_one_attached :article_image

  validates :title, presence: true
  validates :body, presence: true

# User.allで全ユーザーの一覧を取得、それぞれに対してarticleの通知を作成
  after_create do
    User.all.each do |user|
    Notification.create(user_id: user.id, notifiable_type: "Article", notifiable_id: id)
    end
  end

end

