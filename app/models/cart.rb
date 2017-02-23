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

   def remove_item(item_id)
     @contents.delete(item_id)
   end 

   def subtotal(item)
     Item.find(item).price * contents[item.to_s]
   end

   def set_quantity(id, quantity)
     contents[id] = quantity
   end
 end
