class Post < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_one_attached :post_image
  has_one_attached :emotion_image

end
