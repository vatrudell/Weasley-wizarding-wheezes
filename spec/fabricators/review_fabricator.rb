Fabricate.sequence(:content)
Fabricate.sequence(:author)

Fabricator(:review) do
  item    { Fabricate(:item) }
  content { sequence(:content) { |i| "this is the #{i} content"} }
  author  { sequence(:author) {|i| "user_#{i}"} }
  rating  1
end
