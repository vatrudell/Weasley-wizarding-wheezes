require 'rails_helper'

describe "When admin is on orders index" do
  scenario "they can click a button and see all items" do
    item1 = Fabricate(:item)
    item2 = Fabricate(:item)
    item3 = Fabricate(:item)

    admin = Fabricate(:user, username: "admin", email: "admin@admin.com", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on("View All Items")

    cards = page.all(".card")

    expect(cards[0]).to have_content(item1.title)
    expect(cards[0]).to have_content(item1.description)
    expect(cards[0]).to have_content(item1.item_status)
    expect(cards[1]).to have_content(item2.title)
    expect(cards[1]).to have_content(item2.description)
    expect(cards[1]).to have_content(item2.item_status)
    expect(cards[2]).to have_content(item3.title)
    expect(cards[2]).to have_content(item3.description)
    expect(cards[2]).to have_content(item3.item_status)


  end
end
