class PostTagRelation < ApplicationRecord
  # 関連付け
  belongs_to :post
  belongs_to :tag
end