require 'rails_helper'

describe "When user visits root" do
  scenario "They see list of all items" do
    item, item2 = Fabricate.times(2, :item)
    visit root_path

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item2.price)
  end

  scenario "They see a list of most popular items" do
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
    visit root_path

    within(".most-popular") do
      expect(page).to have_content("Our Most Popular Items")
      expect(page).to have_css(".divider")
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item4.title)
    end

    within(".most-popular") do
      unordered_items.each do |item|
        expect(page).to_not have_content(item.title)
      end
    end
  end
end
