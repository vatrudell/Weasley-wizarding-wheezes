require 'rails_helper'

describe Cart do
  it "calculates the total price in the cart" do
    category = Category.create!(name: "toys")
    item_1 = category.items.create!(title: "fake wand",
                                    description: "wow all your friends",
                                    price: 7)
    item_2 = category.items.create!(title: "fake love potion",
                                    description: "wow all your dumb friends",
                                    price: 7)
    cart = Cart.new({})
    cart.add_item(item_1.id)
    cart.add_item(item_1.id)
    cart.add_item(item_2.id)

    expect(cart.total).to eq(21)
  end

  it ".set_quantity updates amount in cart" do
    category = Category.create!(name: "toys")
    item_1 = category.items.create!(title: "fake wand",
                                    description: "wow all your friends",
                                    price: 7)
    item_2 = category.items.create!(title: "fake love potion",
                                    description: "wow all your dumb friends",
                                    price: 7)
    cart = Cart.new({})
    cart.add_item(item_1.id)
    cart.add_item(item_2.id)

    cart.set_quantity(item_1.id, 3)

    expect(cart.contents[item_1.id]).to eq(3)
  end

  it ".item_subtotal returns the subtotal for an item in cart" do
    category = Category.create!(name: "toys")
    item_1 = category.items.create!(title: "fake wand",
                                    description: "wow all your friends",
                                    price: 7)
    item_2 = category.items.create!(title: "fake love potion",
                                    description: "wow all your dumb friends",
                                    price: 7)
    cart = Cart.new({})
    cart.add_item(item_1.id)
    cart.add_item(item_1.id)
    cart.add_item(item_2.id)

    expect(cart.subtotal(item_1.id)).to eq(14)
  end

  it ".total_count returns the total number of items in cart" do
    category = Category.create!(name: "toys")
    item_1 = category.items.create!(title: "fake wand",
                                    description: "wow all your friends",
                                    price: 7)
    item_2 = category.items.create!(title: "fake love potion",
                                    description: "wow all your dumb friends",
                                    price: 7)
    cart = Cart.new({})
    cart.add_item(item_1.id)
    cart.add_item(item_1.id)
    cart.add_item(item_2.id)

    expect(cart.total_count).to eq(3)
  end
end
