require 'rails_helper'

RSpec.describe "when user is in cart" do
  scenario "they can remove item" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 10.99,
                        category: category)
    visit root_path
    click_on "Add to Cart"

    visit cart_path
    
  end
end
