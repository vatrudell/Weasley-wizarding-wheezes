require 'rails_helper'

describe "when they visit the admin dashbash board page" do
  it "they can see all orders" do
    admin = Fabricate(:user, first_name: "Charlotte",
                       last_name: "Moore",
                       username: "Cj",
                       email: "email@email.com",
                       password: "password",
                       role: 1)
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order_one = user.orders.create(total_price: 15, status: "ordered")
    order_two = user.orders.create(total_price: 20, status: "paid")

    visit "/admin/dashboard"

    #
    # within(".browser-default") do
      # click_on "Choose Your Status"
      # click_on "Ordered"
    # end
    select("Ordered", from: "order[status]")

    click_on "sort orders"
    #save_and_open_page
    within(".striped") do
      expect(page).to have_content(order_one.id)
      expect(page).to have_link("View")
      expect(page).to_not have_content(order_two.id)
    end

    select("Paid", from: "order[status]")
    click_on "sort orders"

    within(".striped") do
      expect(page).to have_content(order_two.id)
      expect(page).to have_link("View")
      expect(page).to_not have_content(order_one.id)
    end
  end
end
