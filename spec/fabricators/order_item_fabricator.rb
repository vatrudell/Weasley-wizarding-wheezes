Fabricator(:order_item) do
  order    Fabricate(:order)
  item     Fabricate(:item)
  quantity 1
end
