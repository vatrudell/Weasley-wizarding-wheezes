require 'rails_helper'

describe "user adds an item to the cart" do
  it "from root path" do
    item = Fabricate(:item)
    visit root_path
    click_on "Add to Cart"

    within(".notice") do
      expect(page).to have_content("#{item.title} added to cart")
    end
    within(".nav-wrapper") do
      click_on "Cart"
    end

    expect(current_path).to eq('/cart')
    within("table") do
      expect(page).to have_link(item.title)
      expect(page).to have_content(item.price)
      expect(page).to have_content(item.description)
    end

    within(".total") do
      expect(page).to have_content(item.price)
    end
  end

  it 'from show page' do
    item = Fabricate(:item)
    visit item_path(item)

    click_on 'Add to Cart'

    within('.notice') do
      expect(page).to have_content("#{item.title} added to cart")
    end
  end

  it "updates badge number for cart in navbar" do
    item = Fabricate(:item)
    visit item_path(item)

    click_on 'Add to Cart'

    within('.nav-wrapper .badge') do
      expect(page).to have_content('1')
    end

    click_on 'Add to Cart'

    within('.nav-wrapper') do
      expect(page).to have_content('2')
    end
  end
end
