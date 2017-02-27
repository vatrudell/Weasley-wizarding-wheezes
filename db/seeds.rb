require 'csv'
require_relative '../app/models/category'
require_relative '../app/models/item'

def import_product_csv
  CSV.foreach('db/csv/first_seed.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!(title: row[:title],
                 description: row[:description],
                 price: row[:price],
                 image_tag: row[:image_tag],
                 category: Category.find_or_create_by(name: row[:category]))
  end
  puts "Products have loaded!"
end

User.create!(username: "user",
             email: "email@email.com",
             password: "user",
             first_name: "Standard",
             last_name: "User",
             address: "42 Pine St.")
puts "User Created!"

User.create!(username: "admin",
             email: "admin@email.com",
             password: "admin",
             first_name: "Admin",
             last_name: "User",
             address: "4 Morning Hill Lane",
             role: 1)

puts "Admin Created!"

Item.delete_all
Category.delete_all
import_product_csv
