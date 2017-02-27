class AddPriceToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :price, :float
  end
end
