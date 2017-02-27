require 'rails_helper'

describe "when admin visits the items page" do
  it "admin can create a new item" do
    adminda = Fabricatior(:user)
    adminda.admin!
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(adminda)
    visit new_item_path

    expect(page).to have_content("Create A New Item")

    category = Category.create(name: "Postions")
    item = Item.new(title: "Love Posions",
                    description: "For all your foolish needs",
                    price: 12.78,
                    image_tag: "http://harrypotter.com/love_postion") #you're going to want to change this

    fill_in "item[title]", with: item.title
    fill_in "item[description]", with: item.description
    fill_in "item[price]", with: item.price
    fill_in "item[image_tag]", with: item.image_tag   ###fix
    fill_in "item[category]", with: category.id 

    click "Submit"

    expect(current_page).to be(items_path)
    expect(page).to have_content(item.title)
  end
end
