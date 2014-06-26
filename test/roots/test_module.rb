require_relative "../parser_helper"

class RootTestModuleDef < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
  
  def test_simplest_module
    @string_input    = <<HERE
module Simple
  5
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Simple", :module_expressions=>[{:integer=>"5"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Simple ,[Ast::IntegerExpression.new(5)] )])
  end

  def test_module_ops
    @string_input    = <<HERE
module Opers
  def foo(x)
    abba = 5
    2 + 5
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Opers", :module_expressions=>[{:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:l=>{:name=>"abba"}, :o=>"= ", :r=>{:integer=>"5"}}, {:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:integer=>"5"}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Opers ,[Ast::FunctionExpression.new(:foo, [Ast::NameExpression.new(:x)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:abba),Ast::IntegerExpression.new(5)),Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(2),Ast::IntegerExpression.new(5))] ,nil )] )])
  end

  def test_module_assign_instance
    @string_input    = <<HERE
module Opers
  @abba = 5
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Opers", :module_expressions=>[{:l=>{:instance_variable=>{:name=>"abba"}}, :o=>"= ", :r=>{:integer=>"5"}}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Opers ,[Ast::AssignmentExpression.new(Ast::VariableExpression.new(:abba),Ast::IntegerExpression.new(5))] )])
  end

  def test_module_if
    @string_input    = <<HERE
module Foo
  def ofthen(n)
    if(0)
      isit = 42
    else
      maybenot = 667
    end
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Foo", :module_expressions=>[{:function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:l=>{:name=>"isit"}, :o=>"= ", :r=>{:integer=>"42"}}], :else=>"else"}, :if_false=>{:expressions=>[{:l=>{:name=>"maybenot"}, :o=>"= ", :r=>{:integer=>"667"}}], :end=>"end"}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Foo ,[Ast::FunctionExpression.new(:ofthen, [Ast::NameExpression.new(:n)] , [Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:isit),Ast::IntegerExpression.new(42))],[Ast::AssignmentExpression.new(Ast::NameExpression.new(:maybenot),Ast::IntegerExpression.new(667))] )] ,nil )] )])
  end

  def test_module_function
    @string_input    = <<HERE
module Soho
  ofthen(3+4 , var)
  def ofthen(n,m)
    44
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Soho", :module_expressions=>[{:call_site=>{:name=>"ofthen"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+", :r=>{:integer=>"4"}}}, {:argument=>{:name=>"var"}}]}, {:function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:name=>"n"}}, {:parameter=>{:name=>"m"}}], :expressions=>[{:integer=>"44"}], :end=>"end"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Soho ,[Ast::CallSiteExpression.new(:ofthen, [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(4)),Ast::NameExpression.new(:var)] ,Ast::NameExpression.new(:self)), Ast::FunctionExpression.new(:ofthen, [Ast::NameExpression.new(:n),Ast::NameExpression.new(:m)] , [Ast::IntegerExpression.new(44)] ,nil )] )])
  end

  def test_function_without_braces
    @string_input    = <<HERE
class Foo
  def bar
    4
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Foo", :derived_name=>nil, :class_expressions=>[{:function_name=>{:name=>"bar"}, :expressions=>[{:integer=>"4"}], :end=>"end"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ClassExpression.new(:Foo ,nil, [Ast::FunctionExpression.new(:bar, [] , [Ast::IntegerExpression.new(4)] ,nil )] )])
  end

  def test_module_class
    @string_input    = <<HERE
module Foo
  class Bar
    funcall(3+4 , var)
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Foo", :module_expressions=>[{:module_name=>"Bar", :derived_name=>nil, :class_expressions=>[{:call_site=>{:name=>"funcall"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+", :r=>{:integer=>"4"}}}, {:argument=>{:name=>"var"}}]}], :end=>"end"}], :end=>"end"}]}
    @transform_output = Ast::ExpressionList.new( [Ast::ModuleExpression.new(:Foo ,[Ast::ClassExpression.new(:Bar ,nil, [Ast::CallSiteExpression.new(:funcall, [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(4)),Ast::NameExpression.new(:var)] ,Ast::NameExpression.new(:self))] )] )])
  end
end