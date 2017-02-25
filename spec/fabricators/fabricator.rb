require 'faker'

Fabricator(:item) do
  title { Faker::HarryPotter.unique.book }
  description { Faker::HarryPotter.unique.quote }
  price { Faker:: Number.decimal(2) }
  category  { Fabricate(:category) }
end

Fabricator(:category) do
  name { Faker::HarryPotter.location }
end
