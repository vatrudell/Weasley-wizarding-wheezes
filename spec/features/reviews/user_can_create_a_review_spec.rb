require 'rails_helper'

describe "A signed in user" do
  scenario "can add a rated review to an item" do
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item = Fabricate(:item)

    visit(item_path(item))

    fill_in "review[content]", with: "Awesome product!"
    select("5", from: "review[rating]")
    click_on "Submit Review"

    within(".review") do
      expect(page).to have_content("Awesome product!")
      within(".badge") do
        expect(page).to have_content("5")
      end
    end
  end
end
