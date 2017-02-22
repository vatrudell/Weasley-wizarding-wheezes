class Item < ApplicationRecord

  validates :title, :description, :price, presence: true
  validates :title, :description, uniqueness: true

end
