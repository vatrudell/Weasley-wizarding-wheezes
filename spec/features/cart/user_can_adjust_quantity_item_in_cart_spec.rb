#       And when I increase the quantity
#       Then my current page should be '/cart'
#       And that item's quantity should reflect the increase
#       And the subtotal for that item should increase
#       And the total for the cart should match that increase
#       And when I decrease the quantity
#       Then my current page should be '/cart'
#       And that item's quantity should reflect the decrease
#       And the subtotal for that item should decrease
#       And the total for the cart should match that decrease
require 'rails_helper'

feature "visitor can adjust items in cart" do
  context "from the cart path" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 10.99,
                        category: category)
    @cart = Cart.new(session[:cart])
    @cart.add_item(item.id)

    visit '/cart'

    within(".table") do
      expect(page).to have_content("Love Potion")
      expect(page).to have_content("$10.99")
    end

    within(".table .quantity") do
      expect(page).to have_content("1")
    end

    select("10", from: "item[quantity]")
  end
end
