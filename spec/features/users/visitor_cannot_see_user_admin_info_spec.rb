require 'rails_helper'
describe "an unauthenticated user visiting the site" do
  it "cannot view another user's data" do
    user_two = Fabricate(:user)
    unauthenticated_user = Fabricate(:user,
                                     first_name: "AAA",
                                     email: "a@a.com",
                                     username: "AAA")
    visit admin_dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
      expect(page).to_not have_content("Admin Dashboard")
    end

    visit dashboard_path
    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
    end

    expect(page).to_not have_content(user_two.first_name)
    expect(page).to_not have_content(unauthenticated_user.first_name)
    expect(page).to_not have_content(user_two.email)
    expect(page).to_not have_content(unauthenticated_user.email)
    expect(page).to_not have_content(user_two.username)
    expect(page).to_not have_content(unauthenticated_user.username)
  end
end
