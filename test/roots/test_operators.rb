require_relative "../parser_helper"

class RootTestExpressions < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def simple_op op
    @string_input    = "5 #{op} 3"
    @parse_output = {:expression_list=>[{:l=>{:integer=>"5"}, :o=>"#{op} ", :r=>{:integer=>"3"}}]}
    @transform_output = s(:list, [s(:operator, op, s(:int, 5), s(:int, 3))])
  end
  def test_simple_multiply
    simple_op "*"
  end
  def test_simple_devide
    simple_op "/"
  end
  def test_simple_plus
    simple_op "+"
  end
  def test_simple_minus
    simple_op "-"
  end
  def test_simple_greater
    simple_op ">"
  end
  def test_simple_smaller
    simple_op "<"
  end
  def test_op_two_variable
    @string_input    = "a - b"
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"- ", :r=>{:name=>"b"}}]}
    @transform_output = s(:list, [s(:operator, "-", s(:name, "a"), s(:name, "b"))])
  end
  def test_op_variable
    @string_input    = "a - 5"
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"- ", :r=>{:integer=>"5"}}]}
    @transform_output = s(:list, [s(:operator, "-", s(:name, "a"), s(:int, 5))])
  end
  def test_op_variable_string
    @string_input    = 'a - "st"'
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"- ", :r=>{:string=>[{:char=>"s"}, {:char=>"t"}]}}]}
    @transform_output = s(:list, [s(:operator, "-", s(:name, "a"), s(:string, "st"))])
  end
  def test_op_variable_true
    @string_input    = 'a == true'
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"== ", :r=>{:true=>"true"}}]}
    @transform_output = s(:list, [s(:operator, "==", s(:name, "a"), s(:true))])
  end
  def test_two_same_ops
    @string_input    = '2 + 3 + 4'
    @parse_output = {:expression_list=>[{:l=>{:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:integer=>"3"}}, :o=>"+ ", :r=>{:integer=>"4"}}]}
    @transform_output = s(:list, [s(:operator, "+", s(:operator, "+", s(:int, 2), s(:int, 3)), s(:int, 4))])
  end
  def test_two_different_ops
    @string_input    = '2 + 3 * 4'
    @parse_output = {:expression_list=>[{:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:l=>{:integer=>"3"}, :o=>"* ", :r=>{:integer=>"4"}}}]}
    @transform_output = s(:list, [s(:operator, "+", s(:int, 2), s(:operator, "*", s(:int, 3), s(:int, 4)))])
  end
  def test_two_different_ops_order
    @string_input    = '2 * 3 + 4'
    @parse_output = {:expression_list=>[{:l=>{:l=>{:integer=>"2"}, :o=>"* ", :r=>{:integer=>"3"}}, :o=>"+ ", :r=>{:integer=>"4"}}]}
    @transform_output = s(:list, [s(:operator, "+", s(:operator, "*", s(:int, 2), s(:int, 3)), s(:int, 4))])
  end
  def test_assignment
    @string_input    = "a = 5"
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"5"}}]}
    @transform_output = s(:list, [s(:assign, s(:name, "a"), s(:int, 5))])
  end
  def test_assignment_instance
    @string_input    = "a = 5"
    @parse_output = {:expression_list=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"5"}}]}
    @transform_output = s(:list, [s(:assign, s(:name, "a"), s(:int, 5))])
  end

end
