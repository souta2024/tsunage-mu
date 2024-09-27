class Post < ApplicationRecord
  before_save :set_published_at

  validates :body, presence: true, length: {in: 1..1000}

  has_many :comments
  has_many :post_favorites, dependent: :destroy
  has_many :post_histories, dependent: :destroy

  belongs_to :user


  def favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end

  def set_published_at
    if is_draft == false && published_at.nil?
      self.published_at = Time.zone.now
    elsif is_draft_changed? && is_draft == false
      self.published_at = Time.current
    end
  end

  def self.search_for_post(word, search)
    if search == "partial_match"
      Post.where("body LIKE?", "%#{word}%")
    elsif search == "forward_match"
      Post.where("body LIKE?", "#{word}%")
    elsif search == "backward_match"
      Post.where("body LIKE?", "%#{word}")
    elsif search == "perfect_match"
      Post.where("body LIKE?", "#{word}")
    else
      Post.all
    end
  end

end
