require 'rails_helper'

describe 'when user visits show page for one item' do
  scenario 'they see details for that item' do
    item = Fabricate(:item)

    visit item_path(item)

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item.category.name)
    expect(page).to have_button('Add to Cart')
  end

  scenario "they click on the logo" do
    item = Fabricate(:item)

    visit item_path(item)

    within('.nav-wrapper') do
      click_on "Weasleys' Wizard Wheezes"
    end

    expect(current_path).to eq(root_path)
  end
end
