require 'faker'

Fabricator(:item) do
  title { Faker::HarryPotter.book }
  description { Faker::HarryPotter.quote }
  price { Faker:: Number.decimal(2) }
end

Fabricator(:category) do
  title { Faker::HarryPotter.location }
end
