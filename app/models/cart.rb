 class Cart
   attr_reader :contents

   def initialize(initial_contents)
     @contents   = initial_contents || {}
   end

   def add_item(item_id)
     contents[item_id.to_s] ||= 0
     contents[item_id.to_s] += 1
   end

   def total
     prices = []
    #  byebug
     contents.each_pair do |id, quantity|
       prices << (Item.find(id).price * quantity)
     end
     prices.reduce(:+)
   end

   def remove_item(item_id)
     @contents.delete(item_id)
   end

   def subtotal(item)
     item.price * contents[item.id.to_s]
   end

   def set_quantity(id, quantity)
     contents[id] = quantity
   end

   def total_count
     contents.values.reduce(:+)
   end

   def items
     items_hash = {}
     contents.each do |id, quantity|
       items_hash[Item.find(id)] = quantity
     end
     items_hash
   end
 end
