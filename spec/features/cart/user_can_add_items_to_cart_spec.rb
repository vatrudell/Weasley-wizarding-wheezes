require 'rails_helper'

describe "user adds an item to the cart" do
  it "from root path" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        price: 10.99,
                        category: category)
    visit root_path
    click_on "Add to Cart"

    within(".notice") do
      expect(page).to have_content("Love Potion added to cart")
    end

    click_on "View Cart"

    expect(current_path).to eq('/cart')
    within("table") do
      expect(page).to have_content("Love Potion")
      expect(page).to have_content("$10.99")
    end
    within(".total") do
      expect(page).to have_content("Total: $10.99")
    end
  end

  it 'from show page' do
    category = Category.create!(name: 'potions')
    item = Item.create!(title: 'Love Potion',
                        description: 'make him love you',
                        price: 10.99,
                        category: category)
    visit item_path(item)
    click_on 'Add to Cart'

    within('.notice') do
      expect(page).to have_content('Love Potion added to cart')
    end
  end

end
