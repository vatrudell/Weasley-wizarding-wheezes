require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:item) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:price) }
  end

  it ".subtotal returns the subtotal for an item and quantity" do
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)
    user = Fabricate(:user)
    item1_subtotal = item1.price
    item2_subtotal = (2 * item2.price)
    total = item1_subtotal + item2_subtotal
    order = Order.create!(user: user, total_price: total)
    order_item1 = order.order_items.create!(order: order,
                                            item: item1,
                                            quantity: 1,
                                            price: item1.price)
    order_item2 = order.order_items.create!(order: order,
                                            item: item2,
                                            quantity: 2,
                                            price: item2.price)

    expect(order_item1.subtotal).to eq(item1_subtotal)
    expect(order_item2.subtotal).to eq(item2_subtotal)
  end
end
