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

  scenario 'if user is logged in they see a link to their dashboard' do
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(page).to have_content("User Info")
    expect(page).to have_content("Orders")
    expect(page).to_not have_content("Admin Dashboard")

    user.admin!

    visit root_path

    expect(page).to have_content("Admin Dashboard")
  end
end
