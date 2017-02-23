require 'rails_helper'

describe "User can view own show page" do
  scenario "and see account details" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Cj")
    expect(page).to have_content("email@email.com")
  end
end
