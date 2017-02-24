require 'rails_helper'

describe "when an authenticated user visits their cart" do
  it "they can checkout with one item and the order saves" do
    user = Fabricate(:user)
    item = Fabricate(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit items_path
    click_on "Add to Cart"
    click_on "Cart"

    click_on "Check Out"

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("1")

    within(".success") do
      expect(page).to have_content("Mischief is coming your way, you have successfully placed your order!")
    end
  end

  it "they can checkout with two items" do
  user = Fabricate(:user)
  item = Fabricate(:item)
  item2 = Fabricate(:item)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

  visit item_path(item)
  click_on "Add to Cart"
  visit item_path(item2)
  click_on "Add to Cart"
  click_on "Cart"
  click_on "Check Out"

  expect(current_path).to eq(orders_path)
  expect(page).to have_content("2")

  within(".success") do
    expect(page).to have_content("Mischief is coming your way, you have successfully placed your order!")
  end
end
end
