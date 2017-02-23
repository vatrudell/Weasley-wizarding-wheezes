require 'rails_helper'

describe "user adds an item to the cart" do
  it "from root path" do
    category = Category.create!(name: "potions")
    item = Item.create!(title: "Love Potion",
                        description: "make him love you",
                        image_tag: "http://vignette3.wikia.nocookie.net/harrypotter/images/9/91/AviatomobileBox.jpg/revision/latest/scale-to-width-down/180?cb=20111024074034",
                        price: 10.99,
                        category: category)
    visit root_path
    click_on "Add to Cart"

    within(".notice") do
      expect(page).to have_content("Love Potion added to cart")
    end
    within(".nav-wrapper") do
      click_on "Cart"
    end

    expect(current_path).to eq('/cart')
    within("table") do
      expect(page).to have_css("img[src*='http://vignette3.wikia.nocookie.net/harrypotter/images/9/91/AviatomobileBox.jpg/revision/latest/scale-to-width-down/180?cb=20111024074034']")
      expect(page).to have_link("Love Potion")
      expect(page).to have_content("10.99")
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

  it "updates badge number for cart in navbar" do
    category = Category.create!(name: 'potions')
    item = Item.create!(title: 'Love Potion',
                        description: 'make him love you',
                        price: 10.99,
                        category: category)
    visit item_path(item)

    click_on 'Add to Cart'

    within('.nav-wrapper .badge') do
      expect(page).to have_content('1')
    end

    click_on 'Add to Cart'

    within('.nav-wrapper') do
      expect(page).to have_content('2')
    end
  end
end
