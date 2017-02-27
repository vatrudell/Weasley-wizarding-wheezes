class Item < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  enum item_status: ['available', 'retired']

  def get_quantity_in_order(order)
  	get_order_item(order).quantity
  end

  def get_order_item(order)
    order_items.find_by(order_id: order.id)
  end
end
