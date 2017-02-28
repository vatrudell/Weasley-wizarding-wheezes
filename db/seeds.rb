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


def import_user_csv
CSV.foreach('db/csv/users2.csv', headers: true, header_converters: :symbol) do |row|
  User.create!(username: row[:username],
               email: row[:email],
               password: row[:password],
               first_name: row[:first_name],
               last_name: row[:last_name],
               address: row[:address],
               role: row[:role])

end

puts "Admin Created!"
puts "User Created!"
end


def create_orders
  # byebug
  order1 = User.find_by(username: "user").orders.create!(total_price: Item.find_by(title: "Anti Gravity Hat").price + Item.find_by(title: "Aviatomobile").price + Item.find_by(title: "Bang Bang Boggart Banger").price.round(2))
  order1.order_items.create!(item: Item.find_by(title: "Anti Gravity Hat"), quantity: 1, price: Item.find_by(title: "Anti Gravity Hat").price)
  order1.order_items.create!(item: Item.find_by(title: "Aviatomobile"), quantity: 1, price: Item.find_by(title: "Aviatomobile").price)
  order1.order_items.create!(item: Item.find_by(title: "Bang Bang Boggart Banger"), quantity: 1, price: Item.find_by(title: "Bang Bang Boggart Banger").price)
  puts "Order 1 added!"

  order2 = User.find_by(username: "user").orders.create!(total_price: (Item.find_by(title: "Bang Bang Boggart Banger").price + Item.find_by(title: "Bombtastic Bomb").price + Item.find_by(title:"Box 'O' Rockets").price).round(2))
  order2.order_items.create!(item: Item.find_by(title: "Bang Bang Boggart Banger"), quantity: 1, price: Item.find_by(title: "Bang Bang Boggart Banger").price)
  order2.order_items.create!(item: Item.find_by(title: "Bombtastic Bomb"), quantity: 1, price: Item.find_by(title: "Bombtastic Bomb").price)
  order2.order_items.create!(item: Item.find_by(title:"Box 'O' Rockets"), quantity: 1, price: Item.find_by(title:"Box 'O' Rockets").price)
  puts "Order 2 added!"

  order3 = User.find_by(username: "user").orders.create!(total_price: (Item.find_by(title: "Bang Bang Boggart Banger").price * 2 + Item.find_by(title:"Box 'O' Rockets").price).round(2), status: "canceled")
  order3.order_items.create!(item: Item.find_by(title: "Bang Bang Boggart Banger"), quantity: 2, price: Item.find_by(title: "Bang Bang Boggart Banger").price)
  order3.order_items.create!(item: Item.find_by(title:"Box 'O' Rockets"), quantity: 1, price: Item.find_by(title:"Box 'O' Rockets").price)
  puts "Order 3 added!"
end


OrderItem.delete_all
Item.delete_all
Order.delete_all
User.delete_all
Category.delete_all

import_product_csv
import_user_csv
create_orders
