# frozen_string_literal: true

require 'test/unit/assertions'
# rubocop:disable Style/MixinUsage
include Test::Unit::Assertions
# rubocop:enable Style/MixinUsage

def input_error
  raise 'Invalid input'
end

def calculate(n, m)
  input_error unless valid_input?(n, m)
  result = []

  while result.size < n
    a = generate_array(m)
    sum_a = a.join('+')

    next unless valid_sum?(sum_a, result)

    sum_a.gsub!(/\+-|-\+/, '-')
    result << sum_a
    result.uniq!
  end

  result
rescue e
  e
end

private

def valid_input?(n, m)
  [2, 3].include?(m) || n.positive?
end

def generate_array(size)
  size.times.map { rand(-99..99) }.sort.reverse
end

# rubocop:disable Security/Eval
def valid_sum?(sum_a, result)
  eval(sum_a).between?(1, 100) && !result.include?(sum_a)
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
# rubocop:enable Security/Eval

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
