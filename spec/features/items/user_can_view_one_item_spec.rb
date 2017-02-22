require 'rails_helper'

describe "when user visits show page for one item" do
  scenario "they see details for that item" do
    category = Category.create!(name: "toys")
    item = category.items.create(title: "Bang Bang Boggart Banger", description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes", price: 10.99 )

    visit item_path(item)

    expect(page).to have_content("Bang Bang Boggart Banger")
    expect(page).to have_content("a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes")
    expect(page).to have_content(10.99)
    expect(page).to have_content("toys")
    expect(page).to have_button("Add to Cart")

  end
end
