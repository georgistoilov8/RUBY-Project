require 'csv'

my_csv = CSV.read('repository.csv')
my_csv.sort! do |a,b|
  if a[1].to_i == b[1].to_i
    [a[0]] <=> [b[0]]
  else
    [b[1].to_i] <=> [a[1].to_i]
  end
end

CSV.open('repository.csv', 'w') do |csv|
  my_csv.each { |element| csv << element }
end
