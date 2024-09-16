class Tag < ApplicationRecord
  has_many :tags, dependent: :destroy
end
