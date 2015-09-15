require_relative "../parser_helper"

class RootTestReturn < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_return_int
    @string_input = 'return 42'
    @parse_output = {:expression_list=>[{:return=>"return", :return_expression=>{:integer=>"42"}}]}
    @transform_output = s(:list, [s(:return, s(:int, 42))])
  end

  def test_return_variable
    @string_input = 'return foo'
    @parse_output = {:expression_list=>[{:return=>"return", :return_expression=>{:name=>"foo"}}]}
    @transform_output = s(:list, [s(:return, s(:name, "foo"))])
  end

  def test_return_string
    @string_input    = 'return "hello"'
    @parse_output = {:expression_list=>[{:return=>"return", :return_expression=>{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}}]}
    @transform_output = s(:list, [s(:return, s(:string, "hello"))])
  end

end
