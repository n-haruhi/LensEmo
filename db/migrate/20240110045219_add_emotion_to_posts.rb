class AddEmotionToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :emotion, :string
  end
end
