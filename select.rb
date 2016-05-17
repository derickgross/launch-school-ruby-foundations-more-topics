# select.rb

def select(array)
  new_array = []

  array.each do |x|
    new_array << x if yield(x)
  end

  p new_array
end

select([1, 2, 3, 4, 5, 6]) {|y| y.odd?}