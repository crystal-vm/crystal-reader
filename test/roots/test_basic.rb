require_relative "../parser_helper"

class TestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_number
    @string_input    = '42 '
    @parse_output = {:expression_list=>[{:integer=>"42"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::IntegerExpression.new(42)])
  end

  def test_name
    @string_input    = 'foo '
    @parse_output = {:expression_list=>[{:name=>"foo"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:foo)])
  end

  def test_name_underscode_start
    @string_input    = '_bar '
    @parse_output = {:expression_list=>[{:name=>"_bar"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:_bar)])
  end

  def test_name_underscode_middle
    @string_input    = 'foo_bar '
    @parse_output = {:expression_list=>[{:name=>"foo_bar"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::NameExpression.new(:foo_bar)])
  end

  def test_instance_variable
    @string_input    = '@foo_bar '
    @parse_output = {:expression_list=>[{:instance_variable=>{:name=>"foo_bar"}}]}
    @transform_output = Ast::ExpressionList.new( [Ast::VariableExpression.new(:foo_bar)])
  end

  def test_module_name
    @string_input    = 'FooBar '
    @parse_output = {:expression_list=>[{:module_name=>"FooBar"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleName.new(:FooBar)])
  end

  def ttest_comment
    out = "# i am a comment \n"
    @string_input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @transform_output = @parse_output #dont transform
  end

  def test_string
    @string_input    = "\"hello\""
    @parse_output =  {:expression_list=>[{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}]}
    @transform_output =  Ast::ExpressionList.new( [Ast::StringExpression.new("hello")])
  end

  def test_string_escapes
    out = 'hello  \nyou'
    @string_input    = '"' + out + '"'
    @parse_output = {:expression_list=>[{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}, {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}]}
    @transform_output =  Ast::ExpressionList.new( [Ast::StringExpression.new(out)])
  end

end