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


Item.delete_all
Category.delete_all
import_product_csv
