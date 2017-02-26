require 'rails_helper'

describe "When user views all orders" do
  scenario "they see all their orders" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    category = Fabricate(:category)
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)

    order1 = user.orders.create(total_price: (item1.price + item2.price))
    order2 = user.orders.create(total_price: (item2.price * 2).round(2))

    OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
    OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)
    OrderItem.create(order_id: order2.id, item_id: item1.id, quantity: 2)

    visit orders_path

    expect(page).to have_content(order1.id.to_s)
    expect(page).to have_content(order1.total_price)
    expect(page).to have_content(order2.id.to_s)
    expect(page).to have_content(order2.total_price)
    expect(page).to have_link("View")
  end
end
