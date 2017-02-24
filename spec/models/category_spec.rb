require "rails_helper"

describe Category, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  context "relationships" do
    it { should have_many(:items) }
  end

  context "callbacks" do
    it { is_expected.to callback(:assign_slug).before(:save) }
  end
end
