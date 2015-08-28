require_relative "../parser_helper"

class TestArguments < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_one_argument
    @input    = '(42)'
    @parse_output = {:argument_list => [{:argument => {:integer => '42'}}] }
    @output =  [Ast::IntegerExpression.new(42) ]
    @root = :argument_list
  end

  def test_argument_list
    @input    = '(42, foo)'
    @parse_output = {:argument_list => [{:argument => {:integer => '42'}},
                                      {:argument => {:name   => 'foo'}}]}
    @output = [Ast::IntegerExpression.new(42), Ast::NameExpression.new('foo')]
    @root = :argument_list
  end

  def test_parameter
    @input = "(foo)"
    @parse_output = {:parameter_list=>[{:parameter=>{:name=>"foo"}}]}
    @output = [Ast::NameExpression.new('foo')]
    @root = :parameter_list
  end

  def test_parameter_list
    @input = "( foo , bar)"
    @parse_output = {:parameter_list => [{:parameter => { :name => "foo"}},
                                        {:parameter => { :name => "bar"}} ]}
    @output = [Ast::NameExpression.new('foo') , Ast::NameExpression.new('bar')]
    @root = :parameter_list
  end

end