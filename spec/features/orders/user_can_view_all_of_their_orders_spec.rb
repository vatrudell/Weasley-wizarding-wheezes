require 'rails_helper'

describe "When user views all orders" do
  scenario "they see all their orders" do
    # user = User.create(first_name: "Charlotte",
    #                    last_name: "Moore",
    #                    username: "Cj",
    #                    email: "email@email.com",
    #                    password: "password")

    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    category = Fabricate(:category)
    item1 = category.items.create(title: "Bang Bang Boggart Banger",
                                 description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes",
                                 price: 7 )

    item2 = category.items.create(title: "Rocket Box",
                                   description: "The Rocket Box was a variety pack containing ten different rockets from the Explosive Enterprises line by Weasleys' Wizard Wheezes.",
                                   price: 8 )


    order1 = user.orders.create(total_price: 15)
    order2 = user.orders.create(total_price: 14)

    OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
    OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)
    OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 2)

    # cart = Cart.new({})
    # cart.add_item(item1.id)
    # cart.add_item(item1.id)
    # cart.add_item(item2.id)
    #
    # cart2 = Cart.new({})
    # cart.add_item(item2.id)
    # cart.add_item(item1.id)
    #
    # order = user.orders.create_order()
    # order2 = user.orders.create_order()
    #
    order1_total = (item1.price*2) + item2.price
    order2_total = (item2.price + item1.price)

    visit orders_path

    expect(page).to have_content(order1.id.to_s)
    expect(page).to have_content(order1_total)
    expect(page).to have_content(order2.id.to_s)
    expect(page).to have_content(order2_total)

  end
end
