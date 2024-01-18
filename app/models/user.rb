class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 関連付け
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :articles, dependent: :destroy

  # avatarという名前でプロフィール画像(アイコン)を保存できるように設定
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # get_avatarメソッド。画像のリサイズが可能。get_avatar(100, 100)等が使える。
  def get_avatar(width, height)
    unless avatar.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      avatar.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    avatar.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストログイン
  def self.guest
    # 以下のemailに一致するレコードをデータベースから検索。あればそのレコードを返し、なければ作成する。
    find_or_create_by!(email: 'guest@email.com') do |user|
      user.username = "ゲスト" # ゲストというユーザー名で作成される。
      user.password = SecureRandom.urlsafe_base64 # ランダムな文字列でパスワードが生成される。
    end
  end

end