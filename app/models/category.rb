class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  has_many :items
  before_save :assign_slug

  def assign_slug
    self.slug = self.name.parameterize if self.name
  end

end
