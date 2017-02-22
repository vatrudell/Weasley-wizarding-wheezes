require 'rails_helper'

describe "visitor can adjust items in cart" do
  it "from the cart path" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 11.00,
                        category: category)

    visit root_path
    click_on "Add to Cart"

    visit '/cart'

    within("table") do
      expect(page).to have_content("Love Potion")
      expect(page).to have_content("$11.0")
    end

    within(".total") do
      expect(page).to have_content("$11.0")
    end

    within("table .quantity") do
      expect(page).to have_content("1")
    end

    save_and_open_page
    select("3", from: "item[quantity]")
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table .quantity") do
      expect(page).to have_content("3")
    end

    within(".total") do
      expect(page).to have_content("$33.00")
    end

    select("2", from: "item[quantity]")
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table .quantity") do
      expect(page).to have_content("2")
    end

    within(".total") do
      expect(page).to have_content("$22.00")
    end
  end
end
