require_relative "../parser_helper"

class TestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_true
    @string_input    = 'true'
    @parse_output = {:true => 'true'}
    @transform_output = s(:true)
    @parser = @parser.basic_type
  end
  def test_false
    @string_input    = 'false'
    @parse_output = {:false => 'false'}
    @transform_output = s(:false)
    @parser = @parser.basic_type
  end
  def test_nil
    @string_input    = 'nil'
    @parse_output = {:nil => 'nil'}
    @transform_output = s(:nil)
    @parser = @parser.basic_type
  end

  def test_number
    @string_input    = '42 '
    @parse_output = {:integer => '42'}
    @transform_output = s(:int , 42)
    @parser = @parser.integer
  end

  def test_name
    @string_input    = 'foo '
    @parse_output = {:name => 'foo'}
    @transform_output = s(:name, 'foo')
    @parser = @parser.name
  end

  def test_name_underscode_start
    @string_input    = '_bar '
    @parse_output = {:name => '_bar'}
    @transform_output = s(:name, '_bar')
    @parser = @parser.name
  end

  def test_name_underscode_middle
    @string_input    = 'foo_bar '
    @parse_output = {:name => 'foo_bar'}
    @transform_output = s(:name, 'foo_bar')
    @parser = @parser.name
  end

  def test_field
     @string_input    = 'int foo_bar '
     @parse_output = {:type=>"int", :name=>"foo_bar"}
     @transform_output = s(:field , :int , :foo_bar)
     @parser = @parser.field
   end

  def test_module_name
    @string_input    = 'FooBar '
    @parse_output = {:module_name=>"FooBar"}
    @transform_output = s(:module , "FooBar")
    @parser = @parser.module_name
  end

  def test_comment
    out = "# i am a comment \n"
    @string_input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @transform_output = @parse_output #dont transform
    @parser = @parser.comment
  end

  def test_string
    @string_input    = "\"hello\""
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}
    @transform_output =  s(:string, "hello")
    @parser = @parser.string
  end

  def test_string_escapes
    out = 'hello  \nyou'
    @string_input    = '"' + out + '"'
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"},
      {:char=>" "}, {:char=>" "}, {:esc=>"n"}, {:char=>"y"}, {:char=>"o"}, {:char=>"u"}]}
    @transform_output =  s(:string, out)
    @parser = @parser.string
  end

end
