require 'rails_helper'

describe "when I visit root" do
  it "as a visitor" do
    item = Fabricate(:item)

    visit root_path
    click_on "Add to Cart"
    visit cart_path

    within("table") do
      expect(page).to have_link(item.title)
      expect(page).to have_content(item.price)
    end

    within(".total") do
      expect(page).to have_content("Total: $#{item.price}")
    end

    expect(page).to_not have_button("Checkout")

    within("#guest-message") do
      expect(page).to have_content("Login or Create Account to Checkout")
    end

    within(".guest-links") do
      expect(page).to have_button("Login")
      expect(page).to have_button("Create Account")
      click_on "Create Account"
    end

    within("form") do
      fill_in "user[first_name]", with: "Razz"
      fill_in "user[last_name]", with: "Fluff"
      fill_in "user[username]", with: "razz"
      fill_in "user[email]", with: "email@email.com"
      fill_in "Address", :with => "123 Turing Lane"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
    end

    click_on "Create Account"

    visit cart_path

    within("table") do
      expect(page).to have_link(item.title)
      expect(page).to have_content(item.price)
    end

    within(".total") do
      expect(page).to have_content("Total: $#{item.price}")
    end

    within(".nav-wrapper") do
      click_on "Logout"
    end

    within(".nav-wrapper") do
      expect(page).to_not have_content("Logout")
      expect(page).to have_content("Login")
    end
  end
end
