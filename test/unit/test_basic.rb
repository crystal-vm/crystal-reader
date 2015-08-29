require_relative "../setup"

class TestBasic < MiniTest::Test
  #test basics and keyword expressions. Keywords includes BasicTypes
  def setup
    @parser = Keywords
  end

  def check
    parse    = @parser.parse(@input)
    assert_equal @input , parse
    assert_equal @output , parse.value
  end

  def test_true
    @input    = 'true  '
    @output = Ast::TrueExpression.new()
    check
  end

  def test_false
    @input    = 'false '
    @output = Ast::FalseExpression.new()
    check
  end

  def test_nil
    @input    = 'nil '
    @output = Ast::NilExpression.new()
    check
  end

  def test_integer
    @input    = '42 '
    @output = Ast::IntegerExpression.new(42)
    check
  end

  def test_name
    @input    = 'foo '
    @output = Ast::NameExpression.new('foo')
    check
  end

  def test_name_underscode_start
    @input    = '_bar '
    @output = Ast::NameExpression.new('_bar')
    check
  end

  def test_name_underscode_middle
    @input    = 'foo_bar '
    @output = Ast::NameExpression.new('foo_bar')
    check
  end

  def test_instance_variable
    @input    = '@foo_bar '
    @output = Ast::VariableExpression.new(:foo_bar)
    check
  end

  def ttest_module_name
    @input    = 'FooBar '
    @parse_output = {:module_name=>"FooBar"}
    @output = Ast::ModuleName.new("FooBar")
    check
  end

  def ttest_comment
    out = "# i am a comment \n"
    @input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @output = @parse_output #dont transform
    check
  end

  def ttest_string
    @input    = "\"hello\""
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}
    @output =  Ast::StringExpression.new('hello')
    check
  end

  def ttest_string_escapes
    out = 'hello  \nyou'
    @input    = '"' + out + '"'
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"},
      {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}
    @output =  Ast::StringExpression.new(out)
    check
  end

end
