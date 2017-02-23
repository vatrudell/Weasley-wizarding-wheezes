 class Cart
   attr_reader :contents

   def initialize(initial_contents)
     @contents = initial_contents || {}

   end

   def add_item(item_id)
     contents[item_id.to_s] ||= 0
     contents[item_id.to_s] += 1
   end

   def total
     prices = []
     contents.each_pair do |id, quantity|
       prices << (Item.find(id).price * quantity)
     end
     prices.reduce(:+)
   end

   def subtotal(item)
     price = Item.find(item).price
     quantity = contents[item]
     price * quantity
   end

   def set_quantity(id, quantity)
     contents[id] = quantity
   end
 end
