require 'rails_helper'

describe "When user visits root" do
  scenario "They see list of all items" do
    item = Item.create(title: "Bang Bang Boggart Banger", description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes", price: 10.99 )

    item2 = Item.create(title: "Rocket Box", description: "The Rocket Box was a variety pack containing ten different rockets from the Explosive Enterprises line by Weasleys' Wizard Wheezes.", price: 12.99 )

    visit root_path

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item2.price)
  end
end
