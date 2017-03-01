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
      review_user = Fabricate(:user, first_name: "Jeffery",
                                     last_name: "Lebowski",
                                     username: "TheDude",
                                     password: "OpinionMan",
                                     address: "123 Place Pl",
                                     email: "dude@dude.com")

      item = Fabricate(:item)
      review = item.reviews.create!(content: "I like pretty colors",
                                    rating: 4,
                                    author: review_user.username)

      user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      within(".review") do
        expect(page).to have_content(review_user.username)
        expect(page).to have_content(review.content)
        within(".badge") do
          expect(page).to have_content("Rating: 4")
        end
      end
    end
  end

  context "an un-authenticated user" do
    scenario "cannot create a review" do
      item = Fabricate(:item)
      visit item_path(item)

      expect(page).to have_content("Login or Create Account to Write a Review")
      expect(page).to have_button("Login")
      expect(page).to have_button("Create Account")
    end
  end
end
