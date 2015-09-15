require_relative "../parser_helper"

class RootTestConditional < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_if_else
    @string_input = <<HERE
if(0)
  42
else
  667
end
HERE
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:if, s(:int, 0), [s(:int, 42)], [s(:int, 667)])])
    @parser = @parser
  end

  def test_if_else_expressions
    @string_input = <<HERE
if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
HERE
    @string_input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:if, s(:operator, ">", s(:int, 3), s(:name, "var")), [s(:call, s(:name, "initialize"), [s(:int, 3)], s(:module, "Object"))], [s(:call, s(:name, "new"), [s(:int, 33)], s(:name, "var"))])])
  end

  def test_if_end
    @string_input = <<HERE
if(0)
  42
end
HERE
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:if, s(:int, 0), [s(:int, 42)], nil)])
    @parser = @parser
  end

  def test_if_end_expressions
    @string_input = <<HERE
if(3 > var)
  Object.initialize(3)
end
HERE
    @string_input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:if, s(:operator, ">", s(:int, 3), s(:name, "var")), [s(:call, s(:name, "initialize"), [s(:int, 3)], s(:module, "Object"))], nil)])
  end

end
