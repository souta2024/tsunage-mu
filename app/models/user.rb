class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 半角英数字のみ受け付ける正規表現
  VALID_ACCOUNT_NAME_REGEX = /\A[a-z0-9_]+\z/

  validates :name, presence: true, length: {in: 1..50}
  validates :introduction, length: { maximum: 200 }
  validates :account_id, presence: true,
                         uniqueness: true,
                         length: {in: 5..15},
                         format: { with: VALID_ACCOUNT_NAME_REGEX, message: "小文字の半角英字、半角数字、_のみを使用してください" }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :comments_favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  # フォロー・フォロワー　リレーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
