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
    it { should have_many(:orders)}
  end

  context "process" do
    it { should define_enum_for(:item_status) }
  end

  it "has an image" do
    item = Fabricate(:item)
    expect(item.image_tag.present?).to eq(false)
    item.update_attributes(image_tag: '/assests/images/dumbledore.jpg')
    expect(item.image_tag.present?).to eq(true)
  end
end
