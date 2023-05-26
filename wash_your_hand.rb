require 'test/unit/assertions'
include Test::Unit::Assertions

def wash_hands(num, month)
  minute = num * 21 * month * 30 / 60.0
  second = (minute.ceil - minute) * 60
  "#{minute.to_i} minutes and #{second.to_i} seconds"
end

Test.assert_equal(wash_hands(8, 7), '588 minutes and 0 seconds')
Test.assert_equal(wash_hands(20, 10), '2100 minutes and 0 seconds')
Test.assert_equal(wash_hands(7, 9),  '661 minutes and 30 seconds')
Test.assert_equal(wash_hands(0, 2),  '0 minutes and 0 seconds')
Test.assert_equal(wash_hands(13, 3), '409 minutes and 30 seconds')
Test.assert_equal(wash_hands(1, 1), '10 minutes and 30 seconds')
Test.assert_equal(wash_hands(7, 0), '0 minutes and 0 seconds')
