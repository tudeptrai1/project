require 'test/unit/assertions'
include Test::Unit::Assertions

def dna_error
  raise 'Not a DNA string'
end

def dna_par(dna)
  dna.empty? ? dna_error : dna
  if dna.chars.all?(/[ATGC]/)
    dna = dna.gsub('A', 't').gsub('T', 'a')
    dna = dna.gsub('G', 'c').gsub('C', 'g')
    dna.upcase!
  else
    dna_error
  end
rescue e
  e.message
end

Test.assert_equal(dna_parse('ABCD'), 'Not a DNA string')
Test.assert_equal(dna_parse('AAAA'), 'TTTT')
Test.assert_equal(dna_parse('ATTGC'), 'TAACG')
Test.assert_equal(dna_parse('GTAT'), 'CATA')
Test.assert_equal(dna_parse('AAGG'), 'TTCC', 'String AAGG is')
Test.assert_equal(dna_parse('CGCG'), 'GCGC', 'String CGCG is')
Test.assert_equal(dna_parse('ATTGC'), 'TAACG', 'String ATTGC is')
Test.assert_equal(dna_parse(''), 'Not a DNA string')
