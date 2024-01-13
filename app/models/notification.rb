class Notification < ApplicationRecord
  # モデルの中でxxx_pathメソッドを使用するために必要な記述
  include Rails.application.routes.url_helpers

  # 関連付け
  belongs_to :user
  belongs_to :post
  belongs_to :favorite
  # ポリモーフィック関連として想定され複数のNotifiableモデルに属することを設定
  belongs_to :notifiable, polymorphic: true

  # このmessageメソッドをViewから実行することで通知欄に表示するメッセージを作成
  # notification_typeの種類に応じて出力する内容を変更
  def message
    if notifiable_type === "Post"
      "フォローしている#{notifiable.user.name}さんが#{notifiable.title}を投稿しました"
    else
      "投稿した#{notifiable.post.title}が#{notifiable.user.name}さんにいいねされました"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Post"
      post_path(notifiable.id) # 投稿に対する通知の場合はPostの詳細ページへ
    else
      user_path(notifiable.user.id) # いいねに対する通知の場合はいいねをしたUserの詳細ページへ
    end
  end

end
