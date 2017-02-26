require 'rails_helper'

describe 'user can see nav and footer' do
  scenario 'see nav at root' do
    visit root_path

    expect(page).to have_content("Weasleys' Wizard Wheezes")
  end

  scenario 'see footer at root' do
    visit root_path

    expect(page).to have_content("93 Diagon Alley, London, England")
  end

  scenario 'sees view cart link' do
    visit root_path

    expect(page).to have_link('Cart')
  end

  scenario "sees category dropdown" do
    category = Fabricate(:category)
    category_2 = Fabricate(:category)
    visit root_path

    within("nav") do
      expect(page).to have_link("Products")
    end

    within(".dropdown-content") do
      expect(page).to have_link(category.name)
      expect(page).to have_link(category_2.name)
    end
  end

  scenario 'if user is logged in they see a link to their dashboard' do
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within (".page-footer") do
      expect(page).to have_link("User Info")
      expect(page).to have_link("Orders")
      expect(page).to_not have_link("Admin Dashboard")
    end

    user.admin!

    visit root_path

    within(".page-footer") do
      expect(page).to have_link("Admin Dashboard")
    end
  end

  scenario 'when user is not logged in they see a login button' do
    visit root_path

    within('.nav-wrapper') do
      expect(page).to have_link("Login")
    end
  end

  scenario 'when user is logged in they see a logout button' do
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('.nav-wrapper') do
      expect(page).to have_link("Logout")
    end
  end
end
