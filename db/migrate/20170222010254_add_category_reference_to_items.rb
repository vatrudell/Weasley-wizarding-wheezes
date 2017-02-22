class AddCategoryReferenceToItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :category, index: true
    add_foreign_key :items, :categories
  end
end
