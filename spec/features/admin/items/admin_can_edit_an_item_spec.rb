require 'rails_helper'

describe "when admin visits the items page" do
  it "admin can edit an item" do
    adminda = Fabricatior(:user)
    adminda.admin!
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(adminda)
    visit edit_item_path

    expect(page).to have_content("Create A New Item")

    category = Category.create(name: "Postions")
    item_one = Item.new(title: "Love Posions",
                    description: "For all your foolish needs",
                    price: 12.78,
                    image_tage: "http://harrypotter.com/love_postion"  #you're going to want to change this
    item_two = Item.new(title: "Hair Growing Posions",
                    description: "Grow your hair, grow your teachers hair, get it here",
                    price: 120.78,
                    image_tage: "http://harrypotter.com/hair_growing_postion"  #you're going to want to change this
    fill_in "item[title]", with: item_two.title
    fill_in "item[description]", with: item_two.description
    fill_in "item[price]", with: item_two.price
    fill_in "item[image_tage]" with: item_two.image_tag
    fill_in "item[title]", with: category.id )

    click "Submit"

    expect(current_page).to be(items_path)
    expect(page).to have_content(item_two.title)
    expect(page).to_not have_content(item_one.title)
  end
end
