require 'faker'

Fabricator(:item) do
  title { Faker::HarryPotter.book }
  description { Faker::HarryPotter.quote }
  price { Faker:: Number.decimal(2) }
  category  { Fabricate(:category) }
end

Fabricator(:category) do
  name { Faker::HarryPotter.location }
end
