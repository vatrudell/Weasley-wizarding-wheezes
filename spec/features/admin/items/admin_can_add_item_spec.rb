require 'rails_helper'

 describe "when admin visits the items page" do
   it "admin can create a new item without an image upload" do
     adminda = Fabricate(:user)
     category = Fabricate(:category)
     adminda.admin!
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(adminda)

     visit admin_dashboard_path
     click_on "Create New Item"

     fill_in "item[title]", with: "Test item"
     fill_in "item[description]", with: "Test description"
     fill_in "item[price]", with: "40"
     select category.name, from: "item[category_id]"
     click_on "Submit"

     expect(current_path).to eq(admin_items_path)
     expect(page).to have_content("Test item")
   end
 end
