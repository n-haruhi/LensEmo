class Favorite < ApplicationRecord
  # 関連付け
  belongs_to :user
  belongs_to :post

  # ポリモーフィック関連を介してNotificationモデルと関連付けられる。
  # Notificationモデルをnotifiableという名前で扱う
  has_one :notification, as: :notifiable, dependent: :destroy
end
