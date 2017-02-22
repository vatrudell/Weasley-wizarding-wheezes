class Item < ApplicationRecord
  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true
  belongs_to :category 
end
