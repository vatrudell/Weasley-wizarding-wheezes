require 'rails_helper'

# I cannot view another user's private data, such as current order, etc.
# I should be redirected to login/create account when I try to check out.
describe "an unauthenticated user visiting the site" do
  it "cannot view another user's data" do
    user_two = User.create(first_name: "Charlotte",
                           last_name: "Moore",
                           username: "Cj",
                           email: "email@email.com",
                           password: "password")
    unauthenticated_user = User.create(first_name: "Courtney",
                                       last_name: "Meyerhofer",
                                       username: "pudding",
                                       email: "anon@anon.com",
                                       password: "password")
    visit admin_dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
      expect(page).to_not have_content("Admin Dashboard")
    end

    visit dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
    end
    within(".card-title") do
      expect(page).to_not have_content("Charlotte")
      expect(page).to_not have_content("Courtney")
    end

    within(".card-content ul") do
      expect(page).to_not have_content("email@email.com")
      expect(page).to_not have_content("Cj")
      expect(page).to_not have_content("anon@anon.com")
      expect(page).to_not have_content("pudding")
    end
  end
end
