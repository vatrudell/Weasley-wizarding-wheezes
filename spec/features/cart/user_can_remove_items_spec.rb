require 'rails_helper'

RSpec.describe "when user is in cart" do
  scenario "they can remove item" do
    item = Fabricate(:item)
    visit root_path
    click_on "Add to Cart"

    visit cart_path
    within("table") do
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.price)
    end

    click_on "Remove Item"

    expect(page).to have_content("Sucessfully Removed #{item.title} from your cart")
  end

  scenario "after an item is removed" do
    item = Fabricate(:item)
    visit root_path
    click_on "Add to Cart"

    visit cart_path
    click_on "Remove Item"

    within(".danger") do
      expect(page).to have_link(item.title)
    end
  end
end
