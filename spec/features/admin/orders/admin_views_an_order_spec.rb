require 'rails_helper'

describe "as an authenticated admin" do
  it "when I view an individual order page" do
    user = Fabricate(:user)
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)

    item1_subtotal = (item1.price * 2).round(2)
    item2_subtotal = item2.price
    total = (item1_subtotal + item2_subtotal).round(2)

    order = Order.create!(total_price: total, user: user)
    order_item1 = order.order_items.create!(item: item1, quantity: 2, price: item1.price)
    order_item2 = order.order_items.create!(item: item2, quantity: 1, price: item2.price)

    admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_order_path(order)

    within(".date") do
      expect(page).to have_content(order.created_at)
    end

    within(".user-info") do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.address)
      expect(page).to have_content("Ordered By")
      expect(page).to have_content("Address")
      expect(page).to have_content("Total")
      expect(page).to have_content("Date")
      expect(page).to have_content("Order Status")
    end

    within(".order-items") do
      expect(page).to have_content("Item")
      expect(page).to have_content("Item Price")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("Subtotal")
      expect(page).to have_link(item1.title)
      expect(page).to have_content(item1.price)
      expect(page).to have_link(item2.title)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(order_item1.quantity)
      expect(page).to have_content(order_item2.quantity)
      expect(page).to have_content(item1_subtotal)
      expect(page).to have_content(item2_subtotal)
    end

    within(".total") do
      expect(page).to have_content("#{order.total_price}")
    end

    within(".order-status") do
      expect(page).to have_content("ordered")
    end

    click_on "#{item1.title}"
    expect(current_path).to eq(admin_item_path(item1))
  end
end
