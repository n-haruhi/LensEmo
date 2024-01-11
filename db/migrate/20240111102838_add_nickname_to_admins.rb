class AddNicknameToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :nickname, :string
  end
end
