class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :direct_messages
end
