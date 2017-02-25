require 'rails_helper'

describe "When user visits root" do
  scenario "They see list of all items" do
    item = Fabricate(:item)
    item2 = Fabricate(:item)

    visit root_path

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item2.price)
  end
end
