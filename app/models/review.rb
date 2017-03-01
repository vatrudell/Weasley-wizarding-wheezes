class Review < ApplicationRecord
  belongs_to :item

  validates :content, :rating, presence: true

  def self.filter_reviews(rating)
    if rating == "negative_reviews"
      where("rating <= ?", 2)
    elsif rating == "positive_reviews"
      where("rating >= ?", 3)
    else
      all
    end
  end
end
