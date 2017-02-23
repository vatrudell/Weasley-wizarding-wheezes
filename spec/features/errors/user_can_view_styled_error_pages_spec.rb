require 'rails_helper'

describe "user sees content on error pages" do
  it "when directed to 404 page_not_found" do
    visit '/404'

    expect(page).to have_content("Error: 404 page not found")
    expect(page).to have_css("img[src='https://images.pottermore.com/bxd3o8b291gf/1fEajsMwEoeAUWAea6UyqO/59c35e3ef794e790564ed86e713ea497/wand-light_brown-very_long-rope_handle.png']")
  end

  it "when directed to 500 internal_server_error" do
    visit '/500'

    expect(page).to have_content("Error: 500 internal server error")
    expect(page).to have_css("img[src='https://images.pottermore.com/bxd3o8b291gf/1fEajsMwEoeAUWAea6UyqO/59c35e3ef794e790564ed86e713ea497/wand-light_brown-very_long-rope_handle.png']")
  end
end
