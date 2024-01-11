class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :articles, dependent: :destroy

  # プロフィール画像
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

end
