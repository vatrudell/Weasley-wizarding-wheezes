require 'rails_helper'

describe "User can view own show page" do
  scenario "and see account details" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
  end
end
