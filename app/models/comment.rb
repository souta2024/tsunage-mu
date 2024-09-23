class Comment < ApplicationRecord
  has_many :comment_favorites, dependent: :destroy
  has_many :comment_histories, dependent: :destroy

  belongs_to :user
  belongs_to :post

  def favorited_by?(user)
    comment_favorites.exists?(user_id: user.id)
  end
end
