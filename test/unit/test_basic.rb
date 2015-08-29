require_relative "../setup"

class TestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  #include ParserHelper

  def setup
    @parser = Keywords
  end

  def check
    parse    = @parser.parse(@input)
    assert_equal @input , parse
    assert_equal @output , parse.value
  end

  def test_true
    @input    = 'true '
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

  def ttest_number
    @input    = '42 '
    @output = Ast::IntegerExpression.new(42)
    @root = :integer
  end

  def ttest_name
    @input    = 'foo '
    @output = Ast::NameExpression.new('foo')
    @root = :name
  end

  def ttest_name_underscode_start
    @input    = '_bar '
    @output = Ast::NameExpression.new('_bar')
    @root = :name
  end

  def ttest_name_underscode_middle
    @input    = 'foo_bar '
    @parse_output = {:name => 'foo_bar'}
    @output = Ast::NameExpression.new('foo_bar')
    @root = :name
  end

  def ttest_instance_variable
    @input    = '@foo_bar '
    @parse_output = {:instance_variable=>{:name=>"foo_bar"}}
    @output = Ast::VariableExpression.new(:foo_bar)
    @root = :instance_variable
  end

  def ttest_module_name
    @input    = 'FooBar '
    @parse_output = {:module_name=>"FooBar"}
    @output = Ast::ModuleName.new("FooBar")
    @root = :module_name
  end

  def ttest_comment
    out = "# i am a comment \n"
    @input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @output = @parse_output #dont transform
    @root = :comment
  end

  def ttest_string
    @input    = "\"hello\""
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}
    @output =  Ast::StringExpression.new('hello')
    @root = :string
  end

  def ttest_string_escapes
    out = 'hello  \nyou'
    @input    = '"' + out + '"'
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"},
      {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}
    @output =  Ast::StringExpression.new(out)
    @root = :string
  end

end
