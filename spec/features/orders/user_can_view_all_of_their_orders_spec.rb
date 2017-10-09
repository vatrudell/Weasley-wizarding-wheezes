require 'rails_helper'

describe "When user views all orders" do
  scenario "they see all their orders" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    Fabricate(:category)
    item1, item2 = Fabricate.times(2, :item)

    order1 = user.orders.create!(total_price: (item1.price + item2.price))
    order2 = user.orders.create!(total_price: (item2.price * 2).round(2))

    OrderItem.create!(order: order1,
                      item: item1,
                      quantity: 1,
                      price: item1.price)
    OrderItem.create!(order: order1,
                      item: item2,
                      quantity: 1,
                      price: item2.price)
    OrderItem.create!(order: order2,
                      item: item1,
                      quantity: 2,
                      price: item1.price)

    visit orders_path

    expect(page).to have_button(order1.id)
    expect(page).to have_content(order1.total_price)
    expect(page).to have_content(order1.total_price)
    expect(page).to have_button(order2.id)

    expect(page).to have_content(order2.total_price)
  end
end
