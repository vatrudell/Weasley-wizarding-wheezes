require 'rails_helper'
# Then I should see see "Login"
# And I should not see "Logout"
feature "when I visit root" do
  context "as a visitor" do
    item = Fabricate(:item)

    visit root_path
    click_on "Add to Cart"
    visit cart_path

    within("table") do
      expect(page).to have_link(item.title)
      expect(page).to have_content(item.price)
    end

    within(".total") do
      expect(page).to have_content("Total: #{item.price}")
    end

    # add within blocks for these four
    
    expect(page).to_not have_content("Checkout")
    expect(page).to have_content("Login or Create Account to Checkout")
    expect(page).to have_link("Login")
    expect(page).to have_link("Create Account")

    click_on "Create Account"

    within("form") do
      fill_in "user[first_name]", with: "Razz"
      fill_in "user[last_name]", with: "Fluff"
      fill_in "user[username]", with: "razz"
      fill_in "user[email]", with: "email@email.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password]", with: "password"
    end

    click_on "Create Account"

    visit cart_path

    within("table") do
      expect(page).to have_link(item.title)
      expect(page).to have_content(item.price)
    end

    within(".total") do
      expect(page).to have_content("Total: #{item.price}")
    end

    # add within blocks for these three
    click_on "Logout"

    expect(page).to_not have_content("Log Out")
    expect(page).to have_content("Log In")

  end
end
