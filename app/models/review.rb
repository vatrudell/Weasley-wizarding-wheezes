class Review < ApplicationRecord
  belongs_to :item

  validates :content, :rating, presence: true

  def self.filter_reviews(rating, item)
    if rating == "negative_reviews"
      where("rating <= ? and item_id = ?", 2, item.id)
    elsif rating == "positive_reviews"
      where("rating >= ? and item_id = ?", 3, item.id)
    else
      where("item_id = ?", item.id)
    end
  end
end
