require_relative "../parser_helper"

class RootTestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_number
    @input    = '42 '
    @output = Ast::ExpressionList.new( [Ast::IntegerExpression.new(42)])
  end

  def test_name
    @input    = 'foo '
    @output = Ast::ExpressionList.new( [Ast::NameExpression.new(:foo)])
  end

  def test_name_underscode_start
    @input    = '_bar '
    @output = Ast::ExpressionList.new( [Ast::NameExpression.new(:_bar)])
  end

  def test_name_underscode_middle
    @input    = 'foo_bar '
    @output = Ast::ExpressionList.new( [Ast::NameExpression.new(:foo_bar)])
  end

  def test_instance_variable
    @input    = '@foo_bar '
    @output = Ast::ExpressionList.new( [Ast::VariableExpression.new(:foo_bar)])
  end

  def test_module_name
    @input    = 'FooBar '
    @output = Ast::ExpressionList.new( [Ast::ModuleName.new(:FooBar)])
  end

  def ttest_comment
    out = "# i am a comment \n"
    @input    =  out.dup #NEEDS the return, which is what delimits the comment
    @output = @parse_output #dont transform
  end

  def test_string
    @input    = "\"hello\""
    @parse_output =  {:expression_list=>[{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}]}
    @output =  Ast::ExpressionList.new( [Ast::StringExpression.new("hello")])
  end

  def test_string_escapes
    out = 'hello  \nyou'
    @input    = '"' + out + '"'
    @parse_output = {:expression_list=>[{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}, {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}]}
    @output =  Ast::ExpressionList.new( [Ast::StringExpression.new(out)])
  end

end
