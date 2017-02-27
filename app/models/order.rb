class Order < ApplicationRecord
  validates :total_price, presence: true

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'paid', 'canceled', 'completed']

  def self.get_by_status(find_status)
  orders = find_by(status: find_status)
   if orders == nil
     orders = []
     orders
   else
     where(status: find_status)
   end
  end

  def submit_order(cart)
    cart.items.each do |item, quantity|
      order_items.create!(item_id: item.id,
                          quantity: quantity,
                          price: item.price)
    end
  end
end
