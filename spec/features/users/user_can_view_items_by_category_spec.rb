require 'rails_helper'

describe 'when user visits category show page' do
  describe 'the path will be the category name' do
    scenario 'the user will see all items belonging to that category' do
      category = Fabricate(:category, name: "Joke Products")
      item1 = Fabricate(:item, category: category)
      item2 = Fabricate(:item, category: category)
      item3 = Fabricate(:item)

      visit '/joke-products'

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to_not have_content(item3.title)
    end
  end
end
