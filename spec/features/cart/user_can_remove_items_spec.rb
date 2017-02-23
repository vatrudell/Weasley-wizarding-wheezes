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
    within("table") do
      expect(page).to have_content("Love Potion")
      expect(page).to have_content("10.99")
    end

    click_on "Remove Item"

    expect(page).to have_content("Sucessfully Removed #{item.title} from your cart")
  end

  scenario "after an item is removed" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 10.99,
                        category: category)
    visit root_path
    click_on "Add to Cart"

    visit cart_path
    click_on "Remove Item"

    within(".danger") do
      expect(page).to have_link(item.title)
    end
  end
end
