require_relative "parser_helper"

class TestRoot < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_double_root
    @string_input = <<HERE
def foo(x) 
  a = 5
end

foo( 3 )
HERE
    @parse_output = [{:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"5"}}], :end=>"end"}, {:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}]
    @transform_output = [Ast::FunctionExpression.new(:foo, [Ast::NameExpression.new(:x)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(5))] ,nil ), Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(3)] ,Ast::NameExpression.new(:self))]
  end

  def test_comments
    @string_input = <<HERE
def foo(x) #here
  a = 0           # a == r1
  b = 1           # b = r2
  while(n<1) do #comment
    tmp = a       # r3 <- r1
    a = b         # r1 <- r2
    b = tmp + b   #  r4 = r2 + r3  (r4 transient)  r2 <- r4 
    putstring(b)  
    n = n - 1     #me  
  end #no
end #anywhere
foo( 3 ) #and more
HERE
    @parse_output = [{:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"<", :r=>{:integer=>"1"}}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"putstring"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}, {:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}]
    @transform_output = [Ast::FunctionExpression.new(:foo, [Ast::NameExpression.new(:x)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(0)),Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::IntegerExpression.new(1)),Ast::WhileExpression.new(Ast::OperatorExpression.new("<", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::NameExpression.new(:b)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::OperatorExpression.new("+", Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:b))), Ast::CallSiteExpression.new(:putstring, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:n),Ast::OperatorExpression.new("-", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)))] )] ,nil ), Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(3)] ,Ast::NameExpression.new(:self))]
  end

  def test_fibo1
    @string_input = <<HERE
def fibonaccit(n)
  a = 0 
  b = 1
  while( n > 1 ) do
    tmp = a
    a = b
    b = tmp + b
    puts(b)
    n = n - 1
  end
end

fibonaccit( 10 )
HERE
    @parse_output = [{:function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}, {:call_site=>{:name=>"fibonaccit"}, :argument_list=>[{:argument=>{:integer=>"10"}}]}]
    @transform_output = [Ast::FunctionExpression.new(:fibonaccit, [Ast::NameExpression.new(:n)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(0)),Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::IntegerExpression.new(1)),Ast::WhileExpression.new(Ast::OperatorExpression.new(">", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::NameExpression.new(:b)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::OperatorExpression.new("+", Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:b))), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:n),Ast::OperatorExpression.new("-", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)))] )] ,nil ), Ast::CallSiteExpression.new(:fibonaccit, [Ast::IntegerExpression.new(10)] ,Ast::NameExpression.new(:self))]
  end
  
  def test_module_method
    @string_input = <<HERE
module Fibo
  def fibonaccit(n)
    a = 0 
  end

  fibonaccit( 10 )
end

HERE
    @parse_output = [{:module_name=>"Fibo", :module_expressions=>[{:function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}], :end=>"end"}, {:call_site=>{:name=>"fibonaccit"}, :argument_list=>[{:argument=>{:integer=>"10"}}]}], :end=>"end"}]
    @transform_output = [Ast::ModuleExpression.new(:Fibo ,[Ast::FunctionExpression.new(:fibonaccit, [Ast::NameExpression.new(:n)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(0))] ,nil ), Ast::CallSiteExpression.new(:fibonaccit, [Ast::IntegerExpression.new(10)] ,Ast::NameExpression.new(:self))] )]
  end

  def test_module_assignment
    @string_input = <<HERE
module Fibo
  a = 5 + foo
  bar( b , a , r)
end

HERE
    @parse_output = [{:module_name=>"Fibo", :module_expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:l=>{:integer=>"5"}, :o=>"+ ", :r=>{:name=>"foo"}}}, {:call_site=>{:name=>"bar"}, :argument_list=>[{:argument=>{:name=>"b"}}, {:argument=>{:name=>"a"}}, {:argument=>{:name=>"r"}}]}], :end=>"end"}]
    @transform_output = [Ast::ModuleExpression.new(:Fibo ,[Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(5),Ast::NameExpression.new(:foo))), Ast::CallSiteExpression.new(:bar, [Ast::NameExpression.new(:b),Ast::NameExpression.new(:a),Ast::NameExpression.new(:r)] ,Ast::NameExpression.new(:self))] )]
  end

  def test_root_module_class
    @string_input = <<HERE
module FooBo
  class Bar
    a = 5 + foo
  end
end

HERE
    @parse_output = [{:module_name=>"FooBo", :module_expressions=>[{:module_name=>"Bar", :derived_name=>nil, :class_expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:l=>{:integer=>"5"}, :o=>"+ ", :r=>{:name=>"foo"}}}], :end=>"end"}], :end=>"end"}]
    @transform_output = [Ast::ModuleExpression.new(:FooBo ,[Ast::ClassExpression.new(:Bar ,nil, [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(5),Ast::NameExpression.new(:foo)))] )] )]
  end

  def test_class_method
    @string_input = <<HERE
class FooBo
  Bar.call(35)
end

HERE
    @parse_output = [{:module_name=>"FooBo", :derived_name=>nil, :class_expressions=>[{:receiver=>{:module_name=>"Bar"}, :call_site=>{:name=>"call"}, :argument_list=>[{:argument=>{:integer=>"35"}}]}], :end=>"end"}]
    @transform_output = [Ast::ClassExpression.new(:FooBo ,nil,[Ast::CallSiteExpression.new(:call, [Ast::IntegerExpression.new(35)] ,Ast::ModuleName.new("Bar"))] )]
  end

end


