class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quantity, presence: true

  def subtotal
    (item.price * quantity).round(2)
  end
end
