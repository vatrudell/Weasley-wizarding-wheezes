require 'rails_helper'
# As a registered user
# When I visit "/admin/dashboard"
# I get a 404
# As an unregistered user
# When I visit "/admin/dashboard"
# I get a 404
describe "user visits admin dashboard" do
  it "as an admin" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password",
                       role: 1)

    expect(user.admin?).to eq(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    within("h1") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "as a registered user" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password")

    expect(user.admin?).to eq(false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
    end
  end

  it "as an unregisterd user" do
  end
end
