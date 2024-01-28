class Notification < ApplicationRecord
  # モデルの中でxxx_pathメソッドを使用するために必要な記述
  include Rails.application.routes.url_helpers
  # 関連付け
  belongs_to :user
  # ポリモーフィック関連として想定され複数のNotifiableモデルに属することを設定
  belongs_to :notifiable, polymorphic: true

  # messageメソッドをViewから実行することで通知欄に表示するメッセージを作成
  # notification_typeの種類に応じて出力する内容を変更
  def message
    if notifiable_type === "Favorite"
      "投稿した「#{notifiable.post.title}」が#{notifiable.user.username}さんにいいねされました"
    elsif notifiable_type === "Article"
      "#{notifiable.user.username}さんが「#{notifiable.title}」を投稿しました"
    end
  end

  def notifiable_path
    if notifiable_type === "Favorite"
      post_path(notifiable.post.id) # いいねの通知ならいいねされた投稿の詳細へ
    elsif notifiable_type === "Article"
      article_path(notifiable.id) # 記事の通知なら該当する記事の詳細ページへ
    end
  end

end
