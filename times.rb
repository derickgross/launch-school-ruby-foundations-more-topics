# times.rb

def times(integer)
  counter = 0

  while counter < integer
    yield(counter)
    counter += 1
  end

  integer
end

times(8) do |x|
  puts x.to_s + " is more than #{x - 1}!"
end