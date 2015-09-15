require_relative "../parser_helper"

class TestBasic < MiniTest::Test
  #test basics and keyword expressions. Keywords includes BasicTypes
  include ParserHelper

  def test_true
    @input    = 'true  '
    @output = s(:true)
    check :keyword_true
  end

  def test_false
    @input    = 'false '
    @output = s(:false)
    check :keyword_false
  end

  def test_nil
    @input    = 'nil '
    @output = s(:nil)
    check :keyword_nil
  end

  def test_integer
    @input    = '42 '
    @output = s(:int , 42)
    check :integer_expression
  end

  def test_name
    @input    = 'foo '
    @output = 'foo'
    check :name_expression
  end

  def test_name_underscode_start
    @input    = '_bar '
    @output = '_bar'
    check :name_expression
  end

  def test_name_underscode_middle
    @input    = 'foo_bar '
    @output = 'foo_bar'
    check :name_expression
  end

  def test_module_name
    @input    = 'FooBar '
    @output = s(:aspect , "FooBar")
    check :aspect_name_expression
  end

  def test_string
    @input    = '"hello"'
    @output =  s(:string , 'hello')
    check :string_expression
  end

  def test_string_escapes
    out = 'hello  \nyou'
    @input    = '"' + out + '"'
    @output =  s(:string , out)
    check :string_expression
  end

end
