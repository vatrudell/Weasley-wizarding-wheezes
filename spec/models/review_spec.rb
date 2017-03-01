require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "relationships" do
    it { should belong_to(:item)}
  end

  describe "validations" do
      it { is_expected.to validate_presence_of(:rating) }
      it { is_expected.to validate_presence_of(:content) }
  end
end
