require 'test/unit/assertions'
include Test::Unit::Assertions

def validate_email(email)
  email.match?(/^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$/)
end

Test.assert_equal(validate_email('@edabit.com'), false)
Test.assert_equal(validate_email('@edabit'), false)
Test.assert_equal(validate_email('matt@edabit.com'), true)
Test.assert_equal(validate_email(''), false, "Don't forget about empty strings!")
Test.assert_equal(validate_email('hello.gmail@com'), false)
Test.assert_equal(validate_email('bill.gates@microsoft.com'), true)
Test.assert_equal(validate_email('hello@email'), false)
Test.assert_equal(validate_email('%^%$#%^%'), false)
Test.assert_equal(validate_email('www.email.com'), false)
Test.assert_equal(validate_email('email'), false)
