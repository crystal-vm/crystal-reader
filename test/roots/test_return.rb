require_relative "../parser_helper"

class RootTestReturn < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_return_int
    @string_input = 'return 42'
    @parse_output = {:expression_list=>[{:name=>"return"}, {:integer=>"42"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:return),Ast::IntegerExpression.new(42)])
  end

  def test_return_variable
    @string_input = 'return foo'
    @parse_output = {:expression_list=>[{:name=>"return"}, {:name=>"foo"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:return),Ast::NameExpression.new(:foo)])
  end

  def test_return_string
    @string_input    = 'return "hello"'
    @parse_output = {:expression_list=>[{:name=>"return"}, {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:return),Ast::StringExpression.new("hello")])
  end

end