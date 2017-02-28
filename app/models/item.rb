class Item < ApplicationRecord
  # attr_reader :image_remote_url
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true, allow_blank: false
  # validates :price, numericality: true #, greater_than => 0

  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  has_attached_file :image, styles: {medium: "200x200", thumb: "100x100"}, default_url: "/images/dumbledore.jpg" # "http://vignette3.wikia.nocookie.net/harrypotter/images/4/40/Albus_Dumbledore_%28HBP_promo%29_3.jpg/revision/latest/scale-to-width-down/700?cb=20150822232849"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  enum item_status: ['available', 'retired']

  def get_quantity_in_order(order)
  	get_order_item(order).quantity
  end

  def get_order_item(order)
    order_items.find_by(order_id: order.id)
  end

  def get_subtotal_on_order(order)
    get_order_item(order).subtotal
  end

  def self.most_popular
    item_ids = select('items.id, count(order_items.item_id) as frequency')
               .joins(:order_items).group('items.id')
               .order('frequency desc')
    item_ids.map { |item| find(item.id) }
  end
  # def image_remote_url(url_value)
  #   self.image = URI.parse(url_value)
  #   @image_remote_url = url_value
  # end
end
