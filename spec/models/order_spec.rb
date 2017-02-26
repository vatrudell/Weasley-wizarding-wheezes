require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:total_price) }
  end

  context "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:items) }
  end

  context "process" do
    it { should define_enum_for(:status)}
  end

  it ".submit_order creates order & order-items from cart" do
    user = Fabricate(:user)
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)
    cart = Cart.new({})
    cart.add_item(item1.id)
    cart.add_item(item1.id)
    cart.add_item(item2.id)

    order = user.orders.create!(total_price: cart.total)
    order.submit
    
    expect(order.persisted?).to eq(true)
    expect(order.order_items.count).to eq(2)
    expect(OrderItem.find_by(item: item1).quantity).to eq(2)
    expect(OrderItem.find_by(item: item2).quantity).to eq(1)
  end
end
