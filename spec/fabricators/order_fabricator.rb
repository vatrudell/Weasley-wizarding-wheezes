Fabricator(:order) do
  user        Fabricate(:user)
  total_price 10.5
  status     
end
