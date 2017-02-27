require 'rails_helper'

describe "when an authenticated user visits their cart" do
  it "they can checkout with one item and the order saves" do
    user = Fabricate(:user)
    item = Fabricate(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit items_path
    click_on "Add to Cart"

    within(".nav-wrapper") do
      click_on "Cart"
    end
    visit cart_path
    click_on "Check Out"

    expect(current_path).to eq(orders_path)
    expect(page).to have_content(Order.all.first.id)

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
    within(".nav-wrapper") do
      click_on "Cart"
    end
    click_on "Check Out"

    expect(current_path).to eq(orders_path)
    # save_and_open_page
    within("table") do
      expect(page).to have_content(Order.all.last.id)
    end

    within(".success") do
      expect(page).to have_content("Mischief is coming your way, you have successfully placed your order!")
    end
  end
end

describe "when guest user visits cart page" do
  it "they are unable to check out but can login or create accout" do
    item = Fabricate(:item)

    visit items_path
    click_on "Add to Cart"
    within(".nav-wrapper") do
      click_on "Cart"
    end

    expect(page).to_not have_link("Check Out")
    expect(page).to have_link("Login")
    expect(page).to have_button("Create Account")
  end
end
