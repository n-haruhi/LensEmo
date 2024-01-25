class Tag < ApplicationRecord
  # 関連付け
  # tagsテーブルから中間テーブルに対して
  has_many :post_tag_relations, dependent: :destroy
  # tagsテーブルから中間テーブルを介してpostsテーブルへ
  has_many :posts, through: :post_tag_relations, dependent: :destroy

  # nameが存在すること
  validates :name, presence: true

end