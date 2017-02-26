require 'rails_helper'

describe "User can view own show page" do
  scenario "and see account details" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within("h1") do
      expect(page).to have_content("Welcome, #{user.first_name}!")
    end

    within(".user-info h4") do
      expect(page).to have_content("My Information")
    end

    within(".user-info") do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end

    within(".my-orders") do
      expect(page).to have_link("My Orders")
      click_on "My Orders"
    end

    expect(current_path).to eq(orders_path)
  end
end
