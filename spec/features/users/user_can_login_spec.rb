require 'rails_helper'

describe "user can log in" do
  it "when they login" do
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
    expect(page).to have_content("Logged in as Cj")
    expect(page).to have_content("Charlotte")
    expect(page).to have_content("Moore")
    expect(page).to have_content("Cj")
    expect(page).to have_content("email@email.com")
  end

  it "and can only see their own data" do
    user_two = User.create(first_name: "Charlotte",
                           last_name: "Moore",
                           username: "Cj",
                           email: "email@email.com",
                           password: "password")
    admin_user = User.create(first_name: "Courtney",
                             last_name: "Meyerhofer",
                             username: "pudding",
                             email: "anon@anon.com",
                             password: "password",
                             role: 1)

    authenticated_user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(authenticated_user)

    visit dashboard_path
    within(".card-title") do
      expect(page).to have_content(authenticated_user.first_name)
      expect(page).to_not have_content("Charlotte")
    end

    within(".card-content ul") do
      expect(page).to have_content(authenticated_user.username)
      expect(page).to have_content(authenticated_user.email)
      expect(page).to_not have_content("email@email.com")
      expect(page).to_not have_content("Cj")
    end

    visit admin_dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
      expect(page).to_not have_content("Admin Dashboard")
    end
  end
end
