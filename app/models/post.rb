class Post < ApplicationRecord
  validates :body, presence: true, length: {in: 1..1000}

  has_many :comments
  has_many :post_favorites, dependent: :destroy
  has_many :post_histories, dependent: :destroy

  belongs_to :user
end
