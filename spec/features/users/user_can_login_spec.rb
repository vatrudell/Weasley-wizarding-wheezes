require 'rails_helper'

describe "user can loggin" do
  it "when nthey login" do
    user = Fabricate(:user, role: 1)
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
end
