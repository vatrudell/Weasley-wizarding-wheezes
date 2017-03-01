require 'rails_helper'

describe "On an item page" do
  context "a signed in user" do
    scenario "can add a rated review to an item" do
      user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      item = Fabricate(:item)

      visit(item_path(item))

      fill_in "review[content]", with: "Awesome product!"
      select("5", from: "review[rating]")
      click_on "Submit Review"

      within(".review") do
        expect(page).to have_content(user.username)
        expect(page).to have_content("Awesome product!")
        within(".badge") do
          expect(page).to have_content("Rating: 5")
        end
      end
    end
    scenario "can see another users review" do
      review = Fabricate(:review)

      user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(review.item)

      within(".review") do
        expect(page).to have_content(review.author)
        expect(page).to have_content(review.content)
        within(".badge") do
          expect(page).to have_content("Rating: 1")
        end
      end
    end
  end

  context "an un-authenticated user" do
    scenario "cannot create a review but can see reviews" do
      review = Fabricate(:review)
      visit item_path(review.item)

      expect(page).to have_content("Login or Create Account to Write a Review")
      expect(page).to have_button("Login")
      expect(page).to have_button("Create Account")

      within(".review") do
        expect(page).to have_content(review.author)
        expect(page).to have_content(review.content)
        within(".badge") do
          expect(page).to have_content("Rating: 1")
        end
      end
    end
  end
end
