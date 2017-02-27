class Item < ApplicationRecord
  # attr_reader :image_remote_url
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_attached_file :image # styles: {medium: "200x200", thumb: "100x100"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  enum item_status: ['available', 'retired']

  def get_quantity_in_order(order)
  	order_items.find_by(order_id: order.id).quantity
  end

  # def image_remote_url(url_value)
  #   self.image = URI.parse(url_value)
  #   @image_remote_url = url_value
  # end
end
