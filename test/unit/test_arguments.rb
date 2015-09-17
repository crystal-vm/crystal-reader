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
    @string_input = "ref foo"
    @parse_output = {:parameter_list=>[{:parameter=>{:type=>"ref", :name=>"foo"}}]}
    @transform_output = [s(:field, :ref, :foo)]
    @parser = @parser.parameter_list
  end

  def test_parameter_list
    @string_input = "int foo , ref bar"
    @parse_output = {:parameter_list=>[{:parameter=>{:type=>"int", :name=>"foo"}}, {:parameter=>{:type=>"ref", :name=>"bar"}}]}
    @transform_output = [s(:field, :int, :foo), s(:field, :ref, :bar)]
    @parser = @parser.parameter_list
  end

end
