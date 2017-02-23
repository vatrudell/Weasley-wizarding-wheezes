class Item < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true
  belongs_to :category

  enum item_status: ['available', 'retired']
end
