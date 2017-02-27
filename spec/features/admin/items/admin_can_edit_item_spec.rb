require 'rails_helper'

describe "when admin visits the items page and selects edit" do
  it "admin can edit an item title, description, price" do
    item = Fabricate(:item)
    adminda = Fabricate(:user)
    category = Fabricate(:category)
    adminda.admin!
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(adminda)

    visit admin_items_path
    click_on "Edit"

    expect(page).to have_content("Edit #{item.title}")

    fill_in "item[title]", with: "Test item"
    fill_in "item[description]", with: "Test description"
    fill_in "item[price]", with: "40"
    select category.name, from: "item[category_id]"
    click_on "Submit"

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Test item")
    expect(page).to_not have_content(item.title)
    expect(page).to have_content("Test description")
    expect(page).to_not have_content(item.description)
  end
end
