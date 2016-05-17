# each.rb

def my_each(array)
  counter = 0
  array.length.times do
    yield(array[counter])
    counter += 1
  end

  array
end

my_each([2, 4, 6, 8]) {|x| puts "#{x} is the next number in the array."}