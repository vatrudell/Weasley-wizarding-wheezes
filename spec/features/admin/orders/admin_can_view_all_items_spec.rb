require 'rails_helper'

describe "When admin is on orders index" do
  scenario "they can click a button and see all items" do
    item1 = Fabricate(:item)
    item2 = Fabricate(:item, title: "Whizbang")
    item3 = Fabricate(:item, item_status: "retired")

    admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on("View All Items")

    cards = page.all(".card")

    within(cards[0]) do
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.item_status)
      expect(page).to have_link("Edit")
    end

    within(cards[1]) do
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item2.item_status)
      expect(page).to have_link("Edit")
    end

    within(cards[2]) do
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item3.description)
      expect(page).to have_content(item3.item_status)
      expect(page).to have_link("Edit")
    end
  end
end
