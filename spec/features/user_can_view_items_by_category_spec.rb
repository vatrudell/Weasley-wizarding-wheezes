require 'rails_helper'

describe 'when user visits category show page' do
  describe 'the path will be the category name' do

    scenario 'the user will see all items belonging to that category' do
      category1 = Category.create!(name: "Joke Products")
      category2 = Category.create!(name: "Sweets")

      item1 = Item.create!(title: "Test1",
                           description: "Test1",
                           price: 1.4,
                           image_tag:"http://vignette4.wikia.nocookie.net/harrypotter/images/0/03/Anti_Gravity_Hat.gif/revision/latest/scale-to-width-down/700?cb=20090813160225",
                           category: category1)
      item2 = Item.create!(title: "Test2",
                           description: "Test2",
                           price: 4,
                           image_tag: "http://vignette4.wikia.nocookie.net/harrypotter/images/9/94/Comb-a-chameleon.jpg/revision/latest/scale-to-width-down/700?cb=20110619024947",
                           category: category1)
      item3 = Item.create!(title: "Test3",
                           description: "Test3",
                           price: 5,
                           image_tag: "http://vignette2.wikia.nocookie.net/harrypotter/images/c/cb/TwinsHeadlessHats.png/revision/latest?cb=20160503152602",
                           category: category2)

      visit '/joke-products'

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to_not have_content(item3.title)
    end
  end
end
