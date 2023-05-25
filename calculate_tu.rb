require 'test/unit/assertions'
include Test::Unit::Assertions

def input_error
 raise "Invalid input"
end  

def calculate(n,m)
  raise input_error unless [2, 3].include?(m) && n.positive?
    
    result = []
    operator = ['+', '-']
    while result.size < n
      
      a = m.times.map{rand(1...100).to_s + operator.sample }
      sum_a = a.join.slice(0...-1)
        
      if eval(sum_a).between?(0,100) && !result.include?(sum_a)
        result << sum_a
    end
  end

  result
    
  rescue  => e
    e
  
end

#Test Numbers == m ? 
Test.assert_equal(calculate(2,3).size,2)
Test.assert_equal(calculate(6,2).size,6)
Test.assert_equal(calculate(15,3).size,15)
Test.assert_equal(calculate(8,2).size,8)

#Test Result Positive and > 100 ? 
Test.assert_block do
  calculate(2, 2).any? { |num| (0..100).include?(eval(num)) }
end
Test.assert_block do
  calculate(6, 3).any? { |num| (0..100).include?(eval(num)) }
end
Test.assert_block do
  calculate(15, 3).any? { |num| (0..100).include?(eval(num)) }
end

#Test Number of Numbers == n ?
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

#Test Overlap in Result ?
Test.assert_equal(calculate(8,2).uniq.size,8)
Test.assert_equal(calculate(1000,3).uniq.size,1000)
Test.assert_equal(calculate(500,2).uniq.size,500)
Test.assert_equal(calculate(6,3).uniq.size,6)
