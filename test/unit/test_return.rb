require_relative "../parser_helper"

class TestReturn < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_return_int
    @input = 'return 42'
    @parse_output = {:return=>"return", :return_expression=>{:integer=>"42"}}
    @output = Ast::ReturnExpression.new(Ast::IntegerExpression.new(42) )
    @root = :simple_return
  end

  def test_return_variable
    @input = 'return foo'
    @parse_output = {:return=>"return", :return_expression=>{:name=>"foo"}}
    @output = Ast::ReturnExpression.new(Ast::NameExpression.new("foo") )
    @root = :simple_return
  end

  def test_return_string
    @input    = 'return "hello"'
    @parse_output = {:return=>"return", :return_expression=>{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}}
    @output = Ast::ReturnExpression.new(Ast::StringExpression.new("hello") )
    @root = :simple_return
  end

  def test_return_true
    @input    = 'return true'
    @parse_output = {:return=>"return", :return_expression=>{:true=>"true"}}
    @output = Ast::ReturnExpression.new(Ast::TrueExpression.new() )
    @root = :simple_return
  end

end