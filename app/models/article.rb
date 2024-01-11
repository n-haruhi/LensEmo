class Article < ApplicationRecord

  belongs_to :user

  has_one_attached :article_image

end
