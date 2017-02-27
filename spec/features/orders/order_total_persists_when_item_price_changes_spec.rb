require 'rails_helper'

describe "user creates an order" do
  it "keeps total constant when item price changes" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    category = Category.create(name: "Joke Products")
    item1 = category.items.create(title: "Bang Bang Boggart Banger",
                                 description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes",
                                 price: 7 )
    item2 = category.items.create(title: "Rocket Box",
                                   description: "The Rocket Box was a variety pack containing ten different rockets from the Explosive Enterprises line by Weasleys' Wizard Wheezes.",
                                   price: 8 )
    order = user.orders.create(total_price: 15)

    order_item1 = OrderItem.create!(order_id: order.id,
                                    item_id: item1.id,
                                    quantity: 1,
                                    price: item1.price)
    order_item2 = OrderItem.create!(order_id: order.id,
                                    item_id: item2.id,
                                    quantity: 1,
                                    price: item2.price)
    visit order_path(order)

    within(".order-items") do
      expect(page).to have_content("$7.00")
      expect(page).to have_content("$8.00")
    end

    within(".order-info") do
      expect(page).to have_content("$15.00")
    end

    expect(order.total_price).to eq(15)
    item1.update_attributes(price: 10)

    visit order_path(order)
    expect(order_item1.price).to eq(7)
    expect(order_item1.subtotal).to eq(7)
    expect(order.total_price).to eq(15)

    within(".order-items") do
      expect(page).to have_content("$7.00")
      expect(page).to have_content("$8.00")
    end

    within(".order-info") do
      expect(page).to have_content("$15.00")
    end
  end
end
