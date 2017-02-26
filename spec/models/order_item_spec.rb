require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:item) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
  end
end
