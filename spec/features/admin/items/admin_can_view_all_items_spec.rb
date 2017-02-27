require 'rails_helper'

describe "When user is on orders index" do
  context "And they are an admin" do
    scenario "they can click a button and see all items" do
      item1 = Fabricate(:item)
      item2 = Fabricate(:item, title: "Whizbang")
      item3 = Fabricate(:item, item_status: "retired")
      admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path
      click_on("View All Items")

      expect(current_path).to eq(admin_items_path)

      items = page.all("tr")

      within(items[0]) do
        expect(page).to have_content("Image")
        expect(page).to have_content("Item")
        expect(page).to have_content("Description")
        expect(page).to have_content("Status")
        expect(page).to have_content("Action")
      end

      within(items[1]) do
        expect(page).to have_link(item1.title)
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.item_status)
        expect(page).to have_link("Edit")
      end

      within(items[2]) do
        expect(page).to have_link(item2.title)
        expect(page).to have_content(item2.description)
        expect(page).to have_content(item2.item_status)
        expect(page).to have_link("Edit")
      end

      within(items[3]) do
        expect(page).to have_link(item3.title)
        expect(page).to have_content(item3.description)
        expect(page).to have_content(item3.item_status)
        expect(page).to have_link("Edit")
      end
    end
  end
  context "and they are a default user" do
    scenario "they see a 404" do
      tem1 = Fabricate(:item)
      item2 = Fabricate(:item, title: "Whizbang")
      item3 = Fabricate(:item, item_status: "retired")

      user = Fabricate(:user)
      admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_items_path

      expect(page).to have_content("Error: 404 page not found")
    end
  end
end
