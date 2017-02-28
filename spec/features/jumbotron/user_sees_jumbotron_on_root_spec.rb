require "rails_helper"

describe "when user first navigates to site" do
  it "they see the jumbotron" do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(current_path).to eq('/')

    save_and_open_page
  end
end
