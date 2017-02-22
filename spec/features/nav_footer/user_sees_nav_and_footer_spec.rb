require 'rails_helper'

describe "user can see nav and footer" do
  scenario "see nav at root" do
    visit root_path

    expect(page).to have_content("Weasleys' Wizard Wheezes")
  end

  scenario "see footer at root" do
    visit root_path

    expect(page).to have_content("93 Diagon Alley, London, England")
  end
end
