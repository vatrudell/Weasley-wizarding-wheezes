require 'rails_helper'

describe "an admin logs in" do
  it "redirects to /admin/dashboard" do
    user = Fabricate(:user, role: 1)

    visit login_path
    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    within(".login-submit") do
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path)
  end
end
