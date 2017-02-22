require 'rails_helper'
RSpec.feature "When a user views their cart", type: :feature do
  xscenario "user see item in cart" do

    # item =  Fabricate(:item)
    category = Category.create(id: 1, name: "wands")
    item = Item.new(title:"Elder wand", description: "Does magical things", price: 13.22, category_id: 1)
    # visit cart_path  #sees the cart path but is a poro
    within (".item_card") do
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.price)
      expect(page).to have_link(item.title)
    end
  end

  xscenario "user sees multiple items in cart" do
    # item_1 =  Fabricate(:item)
    # item_2 =  Fabricate(:item)
    # item_3 =  Fabricate(:item)
    category = Category.create(id: 1, name: "wands")
    item = Item.new(title:"Fox wand", description: "Does magical things", price: 15.22, category_id: 1)
    item = Item.new(title:"Elder wand", description: "Does magical things", price: 20.22, category_id: 1)
    item = Item.new(title:"Elephant wand", description: "Does magical things", price: 13.22, category_id: 1)

    visit cart_path  #sees the cart path but is a poro

    expect(page).to have_content([item_1, item_2, item_3])
  end

end
