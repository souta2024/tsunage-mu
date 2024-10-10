class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 半角英数字のみ受け付ける正規表現
  VALID_ACCOUNT_NAME_REGEX = /\A[A-Za-z0-9_]+\z/

  validates :name, presence: true, length: {in: 1..50}
  validates :introduction, length: { maximum: 200 }
  validates :account_id, presence: true,
                         uniqueness: true,
                         length: {in: 5..15},
                         format: { with: VALID_ACCOUNT_NAME_REGEX, message: "英数字と_のみ使用可能です" }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  # フォロー・フォロワー　リレーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def status
    if is_active
      "有効"
    else
      "停止"
    end
  end

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for_name(word, search)
    if search == "partial_match"
      User.where("name LIKE?", "%#{word}%")
    elsif search == "forward_match"
      User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?", "%#{word}")
    elsif search == "perfect_match"
      User.where("name LIKE?", "#{word}")
    else
      User.all
    end
  end

  def self.search_for_account_id(word, search)
    if search == "partial_match"
      User.where("account_id LIKE?", "%#{word}%")
    elsif search == "forward_match"
      User.where("account_id LIKE?", "#{word}%")
    elsif search == "backward_match"
      User.where("account_id LIKE?", "%#{word}")
    elsif search == "perfect_match"
      User.where("account_id LIKE?", "#{word}")
    else
      User.all
    end
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.account_id = SecureRandom.base36(15)
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
