class Category < ApplicationRecord
  # extend FriendlyId
  # friendly_id :name
  validates :name, presence: true, uniqueness: true
  has_many :items
  before_save :assign_slug

  def assign_slug
    self.slug = self.name.parameterize if self.name
  end
  # before_save :save_slug

  # def save_slug
  #   self.name.parameterize
  # end

  # def to_param
  #   self.slug = self.name.parameterize
  # end

end
