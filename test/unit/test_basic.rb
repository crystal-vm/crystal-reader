require_relative "../parser_helper"

class TestBasic < MiniTest::Test
  #test basics and keyword expressions. Keywords includes BasicTypes
  include ParserHelper

  def test_true
    @input    = 'true  '
    @output = Ast::TrueExpression.new()
    check :keyword_true
  end

  def test_false
    @input    = 'false '
    @output = Ast::FalseExpression.new()
    check :keyword_false
  end

  def test_nil
    @input    = 'nil '
    @output = Ast::NilExpression.new()
    check :keyword_nil
  end

  def test_integer
    @input    = '42 '
    @output = Ast::IntegerExpression.new(42)
    check :integer_expression
  end

  def test_name
    @input    = 'foo '
    @output = Ast::NameExpression.new('foo')
    check :name_expression
  end

  def test_name_underscode_start
    @input    = '_bar '
    @output = Ast::NameExpression.new('_bar')
    check :name_expression
  end

  def test_name_underscode_middle
    @input    = 'foo_bar '
    @output = Ast::NameExpression.new('foo_bar')
    check :name_expression
  end

  def test_module_name
    @input    = 'FooBar '
    @output = Ast::ModuleName.new("FooBar")
    check :module_name_expression
  end

  def test_string
    @input    = '"hello"'
    @output =  Ast::StringExpression.new('hello')
    check :string_expression
  end

  def test_string_escapes
    out = 'hello  \nyou'
    @input    = '"' + out + '"'
    @output =  Ast::StringExpression.new(out)
    check :string_expression
  end

end
