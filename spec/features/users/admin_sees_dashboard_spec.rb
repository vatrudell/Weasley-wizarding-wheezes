require 'rails_helper'

describe "user visits admin dashboard" do
  it "as an admin" do
    user = Fabricate(:user, role: 1)

    expect(user.admin?).to eq(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    within("h1") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "as a registered user" do
    user = Fabricate(:user)

    expect(user.admin?).to eq(false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
    end
  end

  it "as an unregisterd user" do
    visit '/admin/dashboard'

    within("h1") do
      expect(page).to have_content("Error: 404 page not found")
    end
  end
end
