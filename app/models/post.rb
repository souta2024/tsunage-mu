class Post < ApplicationRecord
  has_many :comments
  has_many :post_favorites, dependent: :destroy
  has_many :post_histories, dependent: :destroy

  belongs_to :user
end
