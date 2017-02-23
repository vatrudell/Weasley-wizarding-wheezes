class AddItemStatusToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :item_status, :integer, default: 0
  end
end
