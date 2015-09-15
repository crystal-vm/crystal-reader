require_relative "../parser_helper"

class TestArguments < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_one_argument
    @string_input    = '(42)'
    @parse_output = {:argument_list => [{:argument => {:integer => '42'}}] }
    @transform_output =  [s(:int, 42)]
    @parser = @parser.argument_list
  end

  def test_argument_list
    @string_input    = '(42, foo)'
    @parse_output = {:argument_list => [{:argument => {:integer => '42'}},
                                      {:argument => {:name   => 'foo'}}]}
    @transform_output = [s(:int, 42), s(:name, "foo")]
    @parser = @parser.argument_list
  end

  def test_parameter
    @string_input = "(foo)"
    @parse_output = {:parameter_list=>[{:parameter=>{:name=>"foo"}}]}
    @transform_output = [s(:name, "foo")]
    @parser = @parser.parameter_list
  end

  def test_parameter_list
    @string_input = "( foo , bar)"
    @parse_output = {:parameter_list => [{:parameter => { :name => "foo"}},
                                        {:parameter => { :name => "bar"}} ]}
    @transform_output = [s(:name, "foo"), s(:name, "bar")]
    @parser = @parser.parameter_list
  end

end
