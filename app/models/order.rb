class Order < ApplicationRecord
  validates :total_price, presence: true

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'paid', 'canceled', 'completed']

  def submit_order(cart)
    cart.items.each do |item, quantity|
      order_items.create!(item_id: item.id,
                          quantity: quantity)
    end
  end
end
