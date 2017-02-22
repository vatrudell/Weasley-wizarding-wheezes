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
end

xdescribe "user views cart" do
  it "user sees multiple items in cart" do
    # item_1 =  Fabricate(:item)
    # item_2 =  Fabricate(:item)
    # item_3 =  Fabricate(:item)
    category = Category.create!(id: 1, name: "wands")
    item_1 = Item.new(title:"Fox wand", description: "Does magical things", price: 15.22, category_id: category)
    item_2 = Item.new(title:"Elder wand", description: "Does magical things", price: 20.22, category_id: category)
    item_3 = Item.new(title:"Elephant wand", description: "Does magical things", price: 13.22, category_id: category)
    cart = [item_1.title, item_2.title, item_3.title]
    visit cart_path  #sees the cart path but is a poro
    table_cell = page.all("table tr")
    # byebug
    # save_and_open_page
    expect(table_cell[0]).to have_content(item_1.title)
  end
end
