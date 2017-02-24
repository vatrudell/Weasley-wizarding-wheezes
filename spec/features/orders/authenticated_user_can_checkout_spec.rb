require 'rails_helper'

describe "when an authenticated user visits their cart" do
  context "they can checkout and the order saves" do

    user = Fabricate(:user)
    item = Fabricate(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # allow_any_instance_of(ApplicationController).to receive(:set_cart) {}

    visit items_path
    click_on "Add to Cart"
    click_on "Card"

    click_on "Check Out"

    expect(current_path).to
  end
end
