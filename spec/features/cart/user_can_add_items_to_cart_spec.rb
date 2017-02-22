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

describe "user views cart" do
  it "user sees multiple items in cart" do
    category = Category.create!(name: "wands")
    item_one = category.items.create!(title:"Fox wand", description: "Does magical things", price: 15.22)
    cart = Cart.new(session[:cart]n         )
    item_two = category.items.create!(title:"Elder wand", description: "Derp", price: 20.22)

    item_three = category.items.create!(title:"Elephant wand", description: "things", price: 13.22)

    items = [item_one, item_two, item_three]
    cart = Cart.new(items)
    visit cart_path
    save_and_open_page
    #byebug
    # table_cell = page.all("table tr")

    # expect(table_cell[0]).to have_content(item_1.title)
    expect(page).to have_content(item_one.title)
    expect(page).to have_content(item_two.title)
    expect(page).to have_content(item_three.title)
  end
end
