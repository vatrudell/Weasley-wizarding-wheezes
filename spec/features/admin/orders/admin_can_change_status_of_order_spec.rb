require 'rails_helper'

describe "when an admin is on their dashboard" do
  context "on order with status ordered" do
    scenario "they can change it to paid" do
      admin = Fabricate(:user, first_name: "Charlotte",
                         last_name: "Moore",
                         username: "Cj",
                         email: "email@email.com",
                         password: "password",
                         role: 1)
     user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      item1 = Fabricate(:item)
      item2 = Fabricate(:item)

      order1 = user.orders.create(total_price: (item1.price + item2.price))

      OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
      OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)

      visit admin_dashboard_path

      within(".striped") do
        expect(page).to have_content("ordered")
        expect(page).to have_button("Paid")
        expect(page).to have_button("Cancel")
        click_on("Paid")
      end

      within(".striped") do
        expect(page).to have_content("paid")
        expect(page).to_not have_button("Paid")
        expect(page).to have_button("Cancel")
      end
    end

    scenario "they can change it to cancelled" do
      admin = Fabricate(:user, first_name: "Charlotte",
                         last_name: "Moore",
                         username: "Cj",
                         email: "email@email.com",
                         password: "password",
                         role: 1)
     user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      item1 = Fabricate(:item)
      item2 = Fabricate(:item)

      order1 = user.orders.create(total_price: (item1.price + item2.price))

      OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
      OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)

      visit admin_dashboard_path

      within(".striped") do
        expect(page).to have_content("ordered")
        expect(page).to have_button("Paid")
        expect(page).to have_button("Cancel")
        click_on("Cancel")
      end

      within(".striped") do
        expect(page).to have_content("canceled")
        expect(page).to_not have_content("ordered")
        expect(page).to_not have_button("Paid")
        expect(page).to_not have_button("Cancel")
      end
    end
  end

  context "on order with status paid" do
    scenario "they can change it to completed" do
      admin = Fabricate(:user, first_name: "Charlotte",
                         last_name: "Moore",
                         username: "Cj",
                         email: "email@email.com",
                         password: "password",
                         role: 1)
     user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      item1 = Fabricate(:item)
      item2 = Fabricate(:item)

      order1 = user.orders.create(total_price: (item1.price + item2.price), status: 'paid')

      OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
      OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)

      visit admin_dashboard_path

      within(".striped") do
        expect(page).to_not have_button("Paid")
        expect(page).to have_button("Cancel")
        expect(page).to have_button("Complete")
        click_on("Complete")
      end

      within(".striped") do
        expect(page).to_not have_button("Paid")
        expect(page).to have_content("completed")
        expect(page).to_not have_button("Complete")
        expect(page).to_not have_button("Cancel")
      end
    end
    scenario "they can change the status to cancelled" do
      admin = Fabricate(:user, first_name: "Charlotte",
                         last_name: "Moore",
                         username: "Cj",
                         email: "email@email.com",
                         password: "password",
                         role: 1)
     user = Fabricate(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      item1 = Fabricate(:item)
      item2 = Fabricate(:item)

      order1 = user.orders.create(total_price: (item1.price + item2.price), status: 'paid')

      OrderItem.create(order_id: order1.id, item_id: item1.id, quantity: 1)
      OrderItem.create(order_id: order1.id, item_id: item2.id, quantity: 1)

      visit admin_dashboard_path

      within(".striped") do
        expect(page).to_not have_button("Paid")
        expect(page).to have_button("Cancel")
        expect(page).to have_button("Complete")
        click_on("Cancel")
      end

      within(".striped") do
        expect(page).to_not have_button("Paid")
        expect(page).to_not have_button("Cancel")
        expect(page).to_not have_button("Complete")
        expect(page).to have_content("canceled")
      end

    end
  end
end
