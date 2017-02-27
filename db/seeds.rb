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
             address: "123 Fake St")

User.create!(username: "admin",
             email: "admin@email.com",
             password: "admin",
             first_name: "Admin",
             last_name: "User",
             address: "123 Fake St",
             role: 'admin')

Item.delete_all
Category.delete_all
import_product_csv
