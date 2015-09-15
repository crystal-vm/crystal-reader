require_relative "../parser_helper"

class TestReturn < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_return_int
    @string_input = 'return 42'
    @parse_output = {:return=>"return", :return_expression=>{:integer=>"42"}}
    @transform_output = s(:return, s(:int, 42))
    @parser = @parser.simple_return
  end

  def test_return_variable
    @string_input = 'return foo'
    @parse_output = {:return=>"return", :return_expression=>{:name=>"foo"}}
    @transform_output = s(:return, s(:name, "foo"))
    @parser = @parser.simple_return
  end

  def test_return_string
    @string_input    = 'return "hello"'
    @parse_output = {:return=>"return", :return_expression=>{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}}
    @transform_output = s(:return, s(:string, "hello"))
    @parser = @parser.simple_return
  end

  def test_return_true
    @string_input    = 'return true'
    @parse_output = {:return=>"return", :return_expression=>{:true=>"true"}}
    @transform_output = s(:return, s(:true))
    @parser = @parser.simple_return
  end

end
