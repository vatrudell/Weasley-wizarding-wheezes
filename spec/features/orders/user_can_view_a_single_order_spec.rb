require 'rails_helper'

describe "when they visit the show page for an order" do
  it "shows item title, price, quantity" do
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

    OrderItem.create(order_id: order.id, item_id: item1.id, quantity: 1)
    OrderItem.create(order_id: order.id, item_id: item2.id, quantity: 1)
    OrderItem.create(order_id: order.id, item_id: item1.id, quantity: 2)

    #order1_total = rder1_total = item1.price + item2.price

    visit order_path(order)

    expect(page).to have_link(item1.title)
    expect(page).to have_content(item1.price)
    expect(page).to have_content(item1.price)
    expect(page).to have_content(order.total_price)
    expect(page).to have_content(order.status)
    expect(page).to have_content(order.created_at)
    expect(page).to have_content(order.updated_at)
  end
end
