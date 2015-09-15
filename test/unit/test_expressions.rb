require_relative "../parser_helper"

class TestExpressions < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_expression_else
    @string_input    = <<HERE
dud
fuu(3)
else
HERE
    @string_input.chop!
    @parse_output = {:expressions=>[{:name=>"dud"},
      {:call_site=>{:name=>"fuu"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}],
      :else=>"else"}
    @transform_output = {:expressions=>[s(:name, "dud"), s(:call, s(:name, "fuu"), [s(:int, 3)])], :else=>"else"}
    @parser = @parser.expressions_else
  end

  def test_expression_end
    @string_input    = <<HERE
name
call(4,6)
end
HERE
    @string_input.chop!
    @parse_output = {:expressions=>[{:name=>"name"},
      {:call_site=>{:name=>"call"}, :argument_list=>[{:argument=>{:integer=>"4"}}, {:argument=>{:integer=>"6"}}]}],
      :end=>"end"}
    @transform_output = {:expressions=>[s(:name, "name"), s(:call, s(:name, "call"), [s(:int, 4), s(:int, 6)])], :end=>"end"}
    @parser = @parser.expressions_end
  end


end
