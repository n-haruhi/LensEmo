class PostTagRelation < ApplicationRecord
  # postsテーブルとtagsテーブルを紐づける中間テーブル
  # 関連付け
  belongs_to :post
  belongs_to :tag
end