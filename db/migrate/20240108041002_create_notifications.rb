class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false, index: true
      t.integer :post_id, null: false, index: true
      t.integer :favorite_id, null: false, index: true
      t.boolean :read
      t.string :notifiable_type
      t.integer :notifiable_id

      t.timestamps
    end

    add_foreign_key :notifications, :users, column: :user_id
    add_foreign_key :notifications, :posts, column: :post_id
    add_foreign_key :notifications, :favorites, column: :favorite_id

  end
end
