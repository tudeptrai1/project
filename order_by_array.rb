require 'test/unit/assertions'
include Test::Unit::Assertions

def ascending?(arr)
  arr.uniq.sort == arr
end

def descending?(arr)
  arr.uniq.sort.reverse == arr
end

def order_by(arr)
  raise 'An error occurred' if !(arr.all? { |x| x.is_a?(Integer) }) || !arr.is_a?(Array)

  if ascending?(arr)
    'yes, ascending'
  elsif descending?(arr)
    'yes, descending'
  else
    'no'
  end
end

Test.assert_equal(order_by([1, 2]), 'yes, ascending')
Test.assert_equal(order_by([15, 7, 3, -8]), 'yes, descending')
Test.assert_equal(order_by([4, 2, 30]), 'no')
Test.assert_equal(order_by([1, 1, 3]), 'no')
