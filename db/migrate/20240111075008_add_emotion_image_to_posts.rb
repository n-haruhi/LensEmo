class AddEmotionImageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :emotion_image, :string
  end
end
