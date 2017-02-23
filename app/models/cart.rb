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
     prices = contents.keys.map do |id|
       Item.find(id).price
     end
     prices.reduce(:+)
   end

   
 end
