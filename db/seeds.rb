require 'csv'
require_relative '../app/models/category'
require_relative '../app/models/item'

def import_product_csv
  CSV.foreach('db/csv/all_wheezes.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!(title: row[:title],
                 description: row[:description],
                 price: row[:price],
                 image_tag: row[:image_tag],
                 category: Category.find_or_create_by(name: row[:category]))
  end
  puts "Products have loaded!"
end

Item.delete_all
Category.delete_all
import_product_csv

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

item1 = Item.find(1)
item2 = Item.find(2)
item3 = Item.find(3)
item4 = Item.find(4)
item5 = Item.find(5)

order1 = user.orders.create!(total_price: (item1.price + item2.price + item3.price).round(2))
order1.order_items.create(item: item1, quantity: 1, price: item1.price)
order1.order_items.create(item: item2, quantity: 1, price: item2.price)
order1.order_items.create(item: item3, quantity: 1, price: item3.price)
puts "Order 1 added!"

order2 = user.orders.create!(total_price: (item3.price + item4.price + item5.price).round(2))
order2.order_items.create(item: item3, quantity: 1, price: item3.price)
order2.order_items.create(item: item4, quantity: 1, price: item4.price)
order2.order_items.create(item: item5, quantity: 1, price: item5.price)
puts "Order 2 added!"

order3 = user.orders.create!(total_price: (item3.price * 2 + item5.price).round(2), status: "canceled")
order3.order_items.create(item: item3, quantity: 2, price: item3.price)
order3.order_items.create(item: item5, quantity: 1, price: item5.price)
puts "Order 3 added!"
