require 'rails_helper'

describe "visitor can adjust items in cart" do
  it "from the cart path" do
    item = Fabricate(:item)
    visit root_path
    click_on "Add to Cart"

    visit '/cart'
    within("table") do
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.price)
    end

    within(".total") do
      expect(page).to have_content(item.price)
    end

    within("table") do
      expect(page).to have_content("1")
    end
    fill_in("session[quantity]", with: 3)
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table") do
      expect(page).to have_content("3")
    end

    within(".total") do
      expect(page).to have_content((3 * item.price).round(2))
    end

    fill_in("session[quantity]", with: 2)
    click_on "Update Cart"

    expect(current_path).to eq('/cart')

    within("table") do
      expect(page).to have_content("2")
    end

    within(".total") do
      expect(page).to have_content(2 * item.price)
    end
  end
end
