require 'rails_helper'

describe "an admin logs in" do
  it "redirects to /admin/dashboard" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password",
                       role: 1)
    visit login_path

    fill_in "session[username]", with: "Cj"
    fill_in "session[password]", with: "password"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    within(".login-submit") do
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path)
  end
end
