require 'rails_helper'

describe "User can view own show page" do
  scenario "and see account details" do
    user = User.create(username: "Cj",
                       email: "email@email.com",
                       password: "password")

    visit user_path(user)

    expect(page).to have_content("Cj")
    expect(page).to have_content("email@email.com")
  end
end
