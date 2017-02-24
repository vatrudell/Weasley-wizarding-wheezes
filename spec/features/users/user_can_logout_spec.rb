require 'rails_helper'

describe "A logged in user " do
  it "can logout" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password")

  visit login_path
  fill_in "session[username]", with: user.username
  fill_in "session[password]", with: user.password
  within(".login-submit") do
    click_on "Login"
  end

  expect(current_path).to eq(dashboard_path)
  click_on "Logout"

  within(".notice") do
    expect(page).to have_content("Logged Out")
  end

  expect(page).to_not have_content("Logout")
  expect(page).to have_content("Login")
  end
end
