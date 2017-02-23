require 'rails_helper'

describe "When user clicks create account" do
  scenario "they are able to create an account" do
    # visit login_path
    #
    # click_on "Create Account"
    #
    # expect(current_path).to eq(new_user_path)

    visit new_user_path

    fill_in "Username", :with => "Cj"
    fill_in "Email", :with => "email@email.com"
    fill_in "Password", :with => "password"
    fill_in "user[password_confirmation]", :with => "password"

    click_on "Create Account"

    expect(page).to have_content("Logged in as Cj")
    expect(page).to have_content("Cj")
    expect(page).to have_content("email@email.com")
  end
end
