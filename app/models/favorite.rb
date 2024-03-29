class Favorite < ApplicationRecord
  # 関連付け
  belongs_to :user
  belongs_to :post

  # user_idとpost_idのペアが一意である（重複しない）状態に制限
  validates :user_id, uniqueness: {scope: :post_id}

  # ポリモーフィック関連を介してNotificationモデルと関連付けられる。
  # Notificationモデルをnotifiableという名前で扱う
  has_one :notification, as: :notifiable, dependent: :destroy

  # 投稿者に対していいねされたことを通知する。
  # post.user_idを使用してPostの投稿者に対して通知を作成
  after_create do
    create_notification(user_id: post.user_id)
  end

end
