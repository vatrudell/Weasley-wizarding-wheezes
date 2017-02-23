require 'rails_helper'

describe "User cannot add item to cart" do
  scenario "from show if item is retired" do
    item = Fabricate(:item)
    item.retired!

    visit item_path(item)

    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")
  end

  scenario "from index view if item is retired" do
    item = Fabricate(:item)
    item.retired!

    visit items_path

    expect(page).to_not have_button("Add to Cart")
    expect(page).to have_button("Retired")
  end
end
