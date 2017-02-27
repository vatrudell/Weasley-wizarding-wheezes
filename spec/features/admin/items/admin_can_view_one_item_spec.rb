require 'rails_helper'

describe "When a user is on items index" do
  context "and they are an admin" do
    scenario "they can view an individual item's show page" do
      item1 = Fabricate(:item)
      item2 = Fabricate(:item, title: "Whizbang")
      item3 = Fabricate(:item, item_status: "retired")
      admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_items_path
      click_on "Whizbang"

      expect(current_path).to eq(admin_item_path(item2))
      save_and_open_page
      within(".card-content") do
        expect(page).to have_content("Whizbang")
        expect(page).to have_content("Price: $#{item2.price}")
        expect(page).to have_content("Category: #{item2.category.name}")
        expect(page).to have_content("Description: #{item2.description}")
        expect(page).to have_content("Status: #{item2.item_status}")
      end

      within(".card-action") do
        expect(page).to have_link("Edit")
      end
    end
  end
end
