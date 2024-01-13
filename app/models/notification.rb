class Notification < ApplicationRecord
  # 関連付け
  belongs_to :user
  belongs_to :post
  belongs_to :favorite
  # ポリモーフィック関連として想定され複数のNotifiableモデルに属することを設定
  belongs_to :notifiable, polymorphic: true
end
