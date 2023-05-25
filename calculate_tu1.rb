require 'test/unit/assertions'
include Test::Unit::Assertions

def input_error
  raise 'Invalid input'
end

def calculate(n, m)
  input_error unless [2, 3].include?(m) || n.positive?

  result = []

  while result.size < n
    a = m.times.map { rand(-99..99) }.sort.reverse
    sum_a = a.join('+')

    next unless eval(sum_a).between?(1, 100) && !result.include?(sum_a)

    sum_a.gsub!(/\+\-|\-\+/, '-')
    result << sum_a
    result.uniq!
  end

  result
rescue => e
  e
end

# Test Numbers == m ?

Test.assert_equal(calculate(2, 3).size, 2)
Test.assert_equal(calculate(6, 2).size, 6)
Test.assert_equal(calculate(15, 3).size, 15)
Test.assert_equal(calculate(8, 2).size, 8)

# Test Result Positive and < 100 ?
Test.assert_block do
  calculate(2, 2).any? { |num| (0..100).include?(eval(num)) }
end
Test.assert_block do
  calculate(6, 3).any? { |num| (0..100).include?(eval(num)) }
end
Test.assert_block do
  calculate(15, 3).any? { |num| (0..100).include?(eval(num)) }
end

# Test Number of Numbers == n ?
Test.assert_block do
  calculate(15, 3).any? { |num| num.split(/[+-]/).size == 3 }
end
Test.assert_block do
  calculate(2, 3).any? { |num| num.split(/[+-]/).size == 3 }
end
Test.assert_block do
  calculate(2, 2).any? { |num| num.split(/[+-]/).size == 2 }
end
Test.assert_block do
  calculate(5, 3).any? { |num| num.split(/[+-]/).size == 3 }
end

# Test Overlap in Result ?
Test.assert_equal(calculate(8, 2).uniq.size, 8)
Test.assert_equal(calculate(1000, 3).uniq.size, 1000)
Test.assert_equal(calculate(900, 2).uniq.size, 900)
Test.assert_equal(calculate(6, 3).uniq.size, 6)
