require 'rails_helper'

describe "When a user visits an item page" do
  scenario "they are able to sort reviews by rating" do
    item = Fabricate(:item)

    review1, review2 = Fabricate.times(2, :review, rating: 2, item: item)

    review3, review4 = Fabricate.times(2, :review, rating: 5, item: item)

    user = Fabricate(:user)
    visit(item_path(item))

    select("Negative Reviews", from: 'review[sort_rating]')
    click_on("Filter Reviews")

    bad_reviews = page.all(".review")

    within(bad_reviews[0]) do
      expect(page).to have_content(review1.author)
      expect(page).to have_content(review1.content)
      within(".badge") do
        expect(page).to have_content(review1.rating)
      end
    end

    within(bad_reviews[1]) do
      expect(page).to have_content(review2.author)
      expect(page).to have_content(review2.content)
      within(".badge") do
        expect(page).to have_content(review2.rating)
      end
    end

    select("Positive Reviews", from: 'review[sort_rating]')
    click_on("Filter Reviews")

    good_reviews = page.all(".review")

    within(good_reviews[0]) do
      expect(page).to have_content(review3.author)
      expect(page).to have_content(review3.content)
      within(".badge") do
        expect(page).to have_content(review3.rating)
      end
    end

    within(good_reviews[1]) do
      expect(page).to have_content(review4.author)
      expect(page).to have_content(review4.content)
      within(".badge") do
        expect(page).to have_content(review4.rating)
      end
    end

    select("All Reviews", from: 'review[sort_rating]')
    click_on("Filter Reviews")

    all_reviews = page.all(".review")

    within(all_reviews[0]) do
      expect(page).to have_content(review1.author)
      expect(page).to have_content(review1.content)
      within(".badge") do
        expect(page).to have_content(review1.rating)
      end
    end

    within(all_reviews[1]) do
      expect(page).to have_content(review2.author)
      expect(page).to have_content(review2.content)
      within(".badge") do
        expect(page).to have_content(review2.rating)
      end
    end

    within(all_reviews[2]) do
      expect(page).to have_content(review3.author)
      expect(page).to have_content(review3.content)
      within(".badge") do
        expect(page).to have_content(review3.rating)
      end
    end

    within(all_reviews[3]) do
      expect(page).to have_content(review4.author)
      expect(page).to have_content(review4.content)
      within(".badge") do
        expect(page).to have_content(review4.rating)
      end
    end
  end
end
