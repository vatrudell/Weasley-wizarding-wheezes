require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
  end

  context "relationships" do
    it { should belong_to(:category)}
    it { should have_many(:order_items)}
  end

  context "process" do
    it { should define_enum_for(:item_status) }
  end
end
