class Review < ApplicationRecord
  belongs_to :item

  validates :content, :rating, presence: true
end
