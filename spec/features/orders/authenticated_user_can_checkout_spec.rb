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
end
