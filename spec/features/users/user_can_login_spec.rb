require 'rails_helper'


describe "user can loggin" do
  it "when nthey login" do
    user = User.create(first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password")
    visit login_path
    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password

    save_and_open_page
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
end
