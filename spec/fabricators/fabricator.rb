require 'faker'
Fabricate.sequence(:title)
Fabricate.sequence(:description)
Fabricate.sequence(:name)

Fabricator(:item) do
  title { sequence(:title, 111) }
  description { sequence(:description) { |i| "this is the #{i} description"} }
  price { Faker:: Number.decimal(2) }
  category  { Fabricate(:category) }
end

Fabricator(:category) do
  name { sequence(:name) { |i| "name#{i}"} }
end
