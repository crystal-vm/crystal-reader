require_relative "../parser_helper"

class TestExpressions < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def simple_op op
    @input    = "5 #{op} 3"
    @parse_output = {:l=>{:integer=>"5"}, :o=>"#{op} ", :r=>{:integer=>"3"}}
    @output = Ast::OperatorExpression.new(op, Ast::IntegerExpression.new(5),Ast::IntegerExpression.new(3))
    @root = :operator_expression
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
  def test_op_variable
    @input    = "a + 35"
    @parse_output = {:l=>{:name=>"a"}, :o=>"+ ", :r=>{:integer=>"35"}}
    @output = Ast::OperatorExpression.new("+", Ast::NameExpression.new(:a),Ast::IntegerExpression.new(35))
    @root = :operator_expression
  end
  def test_op_two_variable
    @input    = "a - b"
    @parse_output = {:l=>{:name=>"a"}, :o=>"- ", :r=>{:name=>"b"}}
    @output = Ast::OperatorExpression.new("-", Ast::NameExpression.new(:a),Ast::NameExpression.new("b"))
    @root = :operator_expression
  end
  def test_op_instance_variable
    @input    = "@a - 5"
    @parse_output = {:l=>{:instance_variable=>{:name=>"a"}}, :o=>"- ", :r=>{:integer=>"5"}}
    @output = Ast::OperatorExpression.new("-", Ast::VariableExpression.new(:a),Ast::IntegerExpression.new(5))
    @root = :operator_expression
  end
  def test_op_variable_string
    @input    = 'a - "st"'
    @parse_output = {:l=>{:name=>"a"}, :o=>"- ", :r=>{:string=>[{:char=>"s"}, {:char=>"t"}]}}
    @output = Ast::OperatorExpression.new("-", Ast::NameExpression.new(:a),Ast::StringExpression.new("st"))
    @root = :operator_expression
  end
  def test_two_same_ops
    @input    = '2 + 3 + 4'
    @parse_output = {:l=>{:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:integer=>"3"}}, :o=>"+ ", :r=>{:integer=>"4"}}
    @output = Ast::OperatorExpression.new("+", Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(2),Ast::IntegerExpression.new(3)),Ast::IntegerExpression.new(4))
    @root = :operator_expression
  end
  def test_two_different_ops
    @input    = '2 + 3 * 4'
    @parse_output = {:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:l=>{:integer=>"3"}, :o=>"* ", :r=>{:integer=>"4"}}}
    @output = Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(2),Ast::OperatorExpression.new("*", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(4)))
    @root = :operator_expression
  end
  def test_two_different_ops_order
    @input    = '2 * 3 + 4'
    @parse_output = {:l=>{:l=>{:integer=>"2"}, :o=>"* ", :r=>{:integer=>"3"}}, :o=>"+ ", :r=>{:integer=>"4"}}
    @output = Ast::OperatorExpression.new("+", Ast::OperatorExpression.new("*", Ast::IntegerExpression.new(2),Ast::IntegerExpression.new(3)),Ast::IntegerExpression.new(4))
    @root = :operator_expression
  end
  def test_assignment
    @input    = "a = 5"
    @parse_output = {:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"5"}}
    @output = Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(5))
    @root = :operator_expression
  end
  def test_assignment_instance
    @input    = "@a = 5"
    @parse_output = {:l=>{:instance_variable=>{:name=>"a"}}, :o=>"= ", :r=>{:integer=>"5"}}
    @output = Ast::AssignmentExpression.new(Ast::VariableExpression.new(:a),Ast::IntegerExpression.new(5))
    @root = :operator_expression
  end

end