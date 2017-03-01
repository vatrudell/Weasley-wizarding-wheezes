require "rails_helper"

describe "when user first navigates to site" do
  it "they see the jumbotron" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(current_path).to eq('/')
    expect(page).to have_button("Welcome, Wizards!")

    within(".jumbo-block") do
      expect(page).to have_content("Start Shopping")
      expect(page).to have_content("Login Here")
      expect(page).to have_content("Create An Account!")
    end
  end

  it "they can navigate using buttons and links" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    click_on("Welcome, Wizards!")

    expect(current_path).to eq(login_path)

    visit root_path

    within(".jumbo-block") do
      click_on("Start Shopping")

      expect(current_path).to eq(items_path)
    end

    visit root_path

    within(".jumbo-block") do
      click_on("Login Here")

      expect(current_path).to eq(login_path)
    end

    visit root_path

    within(".jumbo-block") do
      click_on("Create An Account!")

      expect(current_path).to eq(new_user_path)
    end
  end
end
