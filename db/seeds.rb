require 'csv'
require_relative '../app/models/category'
require_relative '../app/models/item'

def import_product_csv
  CSV.foreach('db/csv/all_wheezes.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!(title: row[:title],
                 description: row[:description],
                 price: row[:price],
                 image_tag: row[:image_tag],
                 category: Category.find_or_create_by(name: row[:category]),
                 item_status: row[:item_status].to_i
                 )
  end
  puts "Products have loaded!"
end


def create_users


user = User.create!(username: "user",
                    email: "email@email.com",
                    password: "user",
                    first_name: "Standard",
                    last_name: "User",
                    address: "123 Fake St" )
puts "User Created!"

admin = User.create!(username: "admin",
                     email: "admin@email.com",
                     password: "admin",
                     first_name: "Admin",
                     last_name: "User",
                     address: "123 Fake St",
                     role: 1)

puts "Admin Created!"
end

def create_orders

order1 = User.find_by(username: "user").orders.create!(total_price: (Item.find(1).price + Item.find(2).price + Item.find(3).price).round(2))
order1.order_items.create!(item: Item.find(1), quantity: 1, price: Item.find(1).price)
order1.order_items.create!(item: Item.find(2), quantity: 1, price: Item.find(2).price)
order1.order_items.create!(item: Item.find(3), quantity: 1, price: Item.find(3).price)
puts "Order 1 added!"

order2 = User.find_by(username: "user").orders.create!(total_price: (Item.find(3).price + Item.find(4).price + Item.find(5).price).round(2))
order2.order_items.create!(item: Item.find(3), quantity: 1, price: Item.find(3).price)
order2.order_items.create!(item: Item.find(4), quantity: 1, price: Item.find(4).price)
order2.order_items.create!(item: Item.find(5), quantity: 1, price: Item.find(5).price)
puts "Order 2 added!"

order3 = User.find_by(username: "user").orders.create!(total_price: (Item.find(3).price * 2 + Item.find(5).price).round(2), status: "canceled")
order3.order_items.create!(item: Item.find(3), quantity: 2, price: Item.find(3).price)
order3.order_items.create!(item: Item.find(5), quantity: 1, price: Item.find(5).price)
puts "Order 3 added!"

end

OrderItem.delete_all
Item.delete_all
Order.delete_all
User.delete_all
Category.delete_all

import_product_csv
create_users
create_orders
