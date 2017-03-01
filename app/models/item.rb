class Item < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true, allow_blank: false


  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews

  has_attached_file :image, styles: {medium: "200x200", thumb: "100x100"}, default_url: "/images/dumbledore.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  enum item_status: ['available', 'retired']

  def self.most_popular
    item_ids = select('items.id, count(order_items.item_id) as frequency')
               .joins(:order_items).group('items.id')
               .order('frequency desc').limit(6)
    item_ids.map { |item| find(item.id) }
  end

  def get_reviews
    unless reviews.nil?
      reviews
    else
      []
    end
  end
end
