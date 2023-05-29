# frozen_string_literal: true

require 'test/unit/assertions'
# rubocop:disable Style/MixinUsage
include Test::Unit::Assertions
# rubocop:enable Style/MixinUsage

PRIORITY = { 'CEO' => 0, 'director' => 1, 'manager' => 2, 'leader' => 3, 'sales' => 4 }.freeze

def valid_input(staffs)
  raise 'Invalid input' unless staffs.is_a?(Array)
end

def sort_prio(staff)
  raise 'Invalid input' unless staff.is_a?(Hash)

  staff[:positions].sort_by! { |e| PRIORITY[e] }
end

def sort_staffs(staffs)
  valid_input(staffs)
  staffs.each { |staff| sort_prio(staff) }
  staffs.sort_by! { |e| PRIORITY[e[:positions][0]] }
end

Test.assert_equal(sort_staffs([{ id: 1, positions: %w[sales leader] },
                               { id: 2, positions: %w[manager sales leader] },
                               { id: 3, positions: %w[director sales CEO] },
                               { id: 4, positions: %w[manager director leader] }]),
                  [{ id: 3, positions: %w[CEO director sales] },
                   { id: 4, positions: %w[director manager leader] },
                   { id: 2, positions: %w[manager leader sales] },
                   { id: 1, positions: %w[leader sales] }])
Test.assert_equal(sort_staffs([{ id: 1, positions: %w[sales leader] }, { id: 2, positions: %w[manager leader sales] }]),
                  [{ id: 2, positions: %w[manager leader sales] }, { id: 1, positions: %w[leader sales] }])
