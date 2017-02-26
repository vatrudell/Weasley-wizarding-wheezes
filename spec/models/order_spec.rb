require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:total_price) }
  end

  context "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:order_items) }
    it { should have_many(:items) }
  end

  context "process" do
    it { should define_enum_for(:status)}
  end
end
