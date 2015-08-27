require_relative "../parser_helper"

class TestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_true
    @string_input    = 'true '
    @parse_output = {:true => 'true'}
    @transform_output = Ast::TrueExpression.new()
    @root = :keyword_true
  end
  def ttest_false
    @string_input    = 'false '
    @parse_output = {:false => 'false'}
    @transform_output = Ast::FalseExpression.new()
    @parser = @parser.basic_type
  end
  def ttest_nil
    @string_input    = 'nil '
    @parse_output = {:nil => 'nil'}
    @transform_output = Ast::NilExpression.new()
    @parser = @parser.basic_type
  end

  def ttest_number
    @string_input    = '42 '
    @parse_output = {:integer => '42'}
    @transform_output = Ast::IntegerExpression.new(42)
    @parser = @parser.integer
  end

  def ttest_name
    @string_input    = 'foo '
    @parse_output = {:name => 'foo'}
    @transform_output = Ast::NameExpression.new('foo')
    @parser = @parser.name
  end

  def ttest_name_underscode_start
    @string_input    = '_bar '
    @parse_output = {:name => '_bar'}
    @transform_output = Ast::NameExpression.new('_bar')
    @parser = @parser.name
  end

  def ttest_name_underscode_middle
    @string_input    = 'foo_bar '
    @parse_output = {:name => 'foo_bar'}
    @transform_output = Ast::NameExpression.new('foo_bar')
    @parser = @parser.name
  end

  def ttest_instance_variable
    @string_input    = '@foo_bar '
    @parse_output = {:instance_variable=>{:name=>"foo_bar"}}
    @transform_output = Ast::VariableExpression.new(:foo_bar)
    @parser = @parser.instance_variable
  end

  def ttest_module_name
    @string_input    = 'FooBar '
    @parse_output = {:module_name=>"FooBar"}
    @transform_output = Ast::ModuleName.new("FooBar")
    @parser = @parser.module_name
  end

  def ttest_comment
    out = "# i am a comment \n"
    @string_input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @transform_output = @parse_output #dont transform
    @parser = @parser.comment
  end

  def ttest_string
    @string_input    = "\"hello\""
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}
    @transform_output =  Ast::StringExpression.new('hello')
    @parser = @parser.string
  end

  def ttest_string_escapes
    out = 'hello  \nyou'
    @string_input    = '"' + out + '"'
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"},
      {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}
    @transform_output =  Ast::StringExpression.new(out)
    @parser = @parser.string
  end

end
