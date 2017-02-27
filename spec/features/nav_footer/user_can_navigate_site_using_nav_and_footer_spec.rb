require 'rails_helper'

describe "guest user can navigate site using navbar" do
  scenario "when user clicks on cart it redirects to cart page" do
    visit root_path
    click_on "Cart"

    expect(current_path).to eq('/cart')
  end

  scenario "when user clicks on brand it redirects to the root" do
    visit cart_path
    click_on "Weasleys' Wizard Wheezes"

    expect(current_path).to eq(root_path)
  end

  scenario "when user clicks on login it redirects to login page" do
    visit root_path
    click_on "Login"

    expect(current_path).to eq(login_path)
  end

  scenario "user can navigate to category show page" do
    category = Fabricate(:category)
    category_2 = Fabricate(:category)

    visit root_path
    click_on "Products"
    click_on "#{category.name}"

    expect(current_path).to eq(category_path(category.slug))

    click_on "#{category_2.name}"

    expect(current_path).to eq(category_path(category_2.slug))
  end
end

describe "authenticated user can navigate site using navbar" do
  scenario "when user clicks on cart it redirects to cart page" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Cart"

    expect(current_path).to eq('/cart')
  end

  scenario "when user clicks on brand it redirects to the root" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_path
    click_on "Weasleys' Wizard Wheezes"

    expect(current_path).to eq(root_path)
  end

  scenario "user can logout using navbar" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Logout"

    expect(current_path).to eq(login_path)
  end

  scenario "user can navigate to category show page" do
    user = Fabricate(:user)
    category = Fabricate(:category)
    category_2 = Fabricate(:category)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    click_on "Products"
    click_on "#{category.name}"

    expect(current_path).to eq(category_path(category.slug))

    click_on "#{category_2.name}"

    expect(current_path).to eq(category_path(category_2.slug))
  end
end

describe "authenticated user can navigate site using footer links" do
  scenario "they click on user info and see their dashboard" do
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    click_on "User Info"
    expect(current_path).to eq(dashboard_path)
  end

  scenario "they click on orders and view their orders" do 
    user = Fabricate(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    click_on "Orders"
    expect(current_path).to eq(orders_path)
  end
end

describe "admin user can navigate to dashboard using footer links" do
  scenario "when they click on admin dashboard link" do
    user_admin = Fabricate(:user)
    user_admin.admin!

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_admin)

    visit root_path
    click_on "Admin Dashboard"

    expect(current_path).to eq(admin_dashboard_path)
  end
end