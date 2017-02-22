require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    context "is valid" do
      it "with valid attributes" do
        item = Item.new(title: "Bang Bang Boggart Banger", description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes", price: 10.99 )

        expect(item).to be_valid
      end
    end

    context "is invalid" do
      it "without a title" do
        item = Item.new( description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes", price: 10.99 )

        expect(item).to be_invalid
      end

      it "without description" do
        item = Item.new(title: "Bang Bang Boggart Banger",  price: 10.99 )

        expect(item).to be_invalid
      end

      it "without price" do
        item = Item.new(title: "Bang Bang Boggart Banger", description: "a rocket from the Explosive Enterprises line by Weasleys' Wizard Wheezes" )

        expect(item).to be_invalid
      end
    end
  end
end
