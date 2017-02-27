require 'rails_helper'

describe "user can login" do
  it "when they login" do
    user = Fabricate(:user)
    visit login_path
    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password

    within(".login-submit") do
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user.username}")
    expect(page).to have_content("#{user.first_name}")
    expect(page).to have_content("#{user.last_name}")
    expect(page).to have_content("#{user.username}")
    expect(page).to have_content("#{user.email}")
  end

  it "and can only see their own data" do
    user_two = Fabricate(:user, first_name: "Razz", username: "AAA", email: "a@a.com")
    authenticated_user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(authenticated_user)

    visit dashboard_path
    within(".user-info") do
      expect(page).to have_content(authenticated_user.first_name)
      expect(page).to_not have_content(user_two.first_name)
    end

    within(".user-info") do
      expect(page).to have_content(authenticated_user.username)
      expect(page).to have_content(authenticated_user.email)
      expect(page).to_not have_content(user_two.email)
      expect(page).to_not have_content(user_two.username)
    end

    visit admin_dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
      expect(page).to_not have_content("Admin Dashboard")
    end
  end
end
