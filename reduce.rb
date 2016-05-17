# reduce.rb

def reduce (array, start=0)
  acc = start
  array.each do |num|
    acc = yield(acc, num)
  end

  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }
p reduce(array, 10) { |acc, num| acc + num }
p reduce(array) { |acc, num| acc + num if num.odd? } 