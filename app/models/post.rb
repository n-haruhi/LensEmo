class Post < ApplicationRecord
  # 関連付け
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # postsテーブルから中間テーブル
  has_many :post_tag_relations, dependent: :destroy
  # postsテーブルから中間テーブルを介してtagsテーブルへ
  has_many :tags, through: :post_tag_relations, dependent: :destroy

  # Active Storageの設定。投稿画像と気持ちを表す画像を用いる。
  has_one_attached :post_image
  has_one_attached :emotion_image

end
