class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name
  validates :name, presence: true, uniqueness: true
  has_many :items

end
