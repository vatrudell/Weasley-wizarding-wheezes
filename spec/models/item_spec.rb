require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
  end

  context "relationships" do
    it { should belong_to(:category)}
    it { should have_many(:order_items)}
    it { should have_many(:orders)}
  end

  context "process" do
    it { should define_enum_for(:item_status) }
  end

  it "has an image" do
    item = Fabricate(:item)
    expect(item.image_tag.present?).to eq(false)
    item.update_attributes(image_tag: '/assests/images/dumbledore.jpg')
    expect(item.image_tag.present?).to eq(true)
  end

  it ".most_popular returns the most frequently ordered items" do
    item1, item2, item3, item4 = Fabricate.times(4, :item)
    unordered_items = Fabricate.times(10, :item)
    user1 = Fabricate(:user)

    order1_total = (item1.price * 2) + item3.price + item2.price
    order1 = user1.orders.create!(total_price: order1_total)
    OrderItem.create!(order: order1,
                      item: item1,
                      quantity: 2,
                      price: item1.price)
    OrderItem.create!(order: order1,
                      item: item2,
                      quantity: 1,
                      price: item2.price)
    OrderItem.create!(order: order1,
                      item: item3,
                      quantity: 1,
                      price: item3.price)

    order2_total = (item3.price * 4) + item4.price
    order2 = user1.orders.create!(total_price: order2_total)
    OrderItem.create!(order: order2,
                      item: item3,
                      quantity: 4,
                      price: item3.price)
    OrderItem.create!(order: order2,
                      item: item4,
                      quantity: 1,
                      price: item4.price)
    expect(Item.most_popular).to eq(item3, item1, item2, item4)
  end
end
