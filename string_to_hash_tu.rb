# frozen_string_literal: true

require 'test/unit/assertions'
# rubocop:disable Style/MixinUsage
include Test::Unit::Assertions
# rubocop:enable Style/MixinUsage

def valid_input?(str, hash1)
  str.is_a?(String) && !str.empty? && hash1.is_a?(Array) && !hash1.empty?
end

def str_to_hash(str, hash1)
  raise StandardError, 'Invalid input' unless valid_input?(str, hash1)

  arr = str.split.each_slice(hash1.size).to_a
  arr.map { |sub_array| hash1.zip(sub_array).to_h.transform_keys(&:to_sym) }
rescue StandardError => e
  e.message
end

# Test case
Test.assert_equal(str_to_hash('red 1 yellow 2 black 3', %w[name id color style]),
                  [{ name: 'red', id: '1', color: 'yellow', style: '2' },
                   { name: 'black', id: '3', color: nil, style: nil }])
Test.assert_equal(str_to_hash('red 1 yellow 2 black 3', %w[name id]),
                  [{ name: 'red', id: '1' }, { name: 'yellow', id: '2' },
                   { name: 'black', id: '3' }])
Test.assert_equal(str_to_hash(123, %w[name id]), 'Invalid input')
Test.assert_equal(str_to_hash([], []), 'Invalid input')
Test.assert_equal(str_to_hash([], 123), 'Invalid input')
