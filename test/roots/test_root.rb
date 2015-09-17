require_relative "../parser_helper"

class RootTestRoot < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_double_root
    @string_input = <<HERE
int foo(ref x)
  a = 5
end

foo( 3 )
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:type=>"ref", :name=>"x"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"5"}}], :end=>"end"}, {:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "foo"), [s(:field, :ref, :x)], [s(:assign, s(:name, "a"), s(:int, 5))]), s(:call, s(:name, "foo"), [s(:int, 3)])])
  end

  def ttest_comments
    @string_input = <<HERE
def foo(x) #here
  a = 0           # a == r1
  b = 1           # b = r2
  while(n<1) #comment
    tmp = a       # r3 <- r1
    a = b         # r1 <- r2
    b = tmp + b   #  r4 = r2 + r3  (r4 transient)  r2 <- r4
    putstring(b)
    n = n - 1     #me
  end #no
end #anywhere
foo( 3 ) #and more
HERE
    @parse_output = {:expression_list=>[{:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"<", :r=>{:integer=>"1"}}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"putstring"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}, {:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}]}
    @transform_output = Ast::ExpressionList.new( [Ast::FunctionExpression.new(:foo, [Ast::NameExpression.new(:x)] , [Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::IntegerExpression.new(0)),Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::IntegerExpression.new(1)),Ast::WhileExpression.new(Ast::OperatorExpression.new("<", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::NameExpression.new(:b)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::OperatorExpression.new("+", Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:b))), Ast::CallSiteExpression.new(:putstring, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:n),Ast::OperatorExpression.new("-", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)))] )] ,nil ),Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(3)] ,Ast::NameExpression.new(:self))])
  end

  def test_fibo1
    @string_input = <<HERE
int fibonaccit(int n)
  a = 0
  b = 1
  while( n > 1 )
    tmp = a
    a = b
    b = tmp + b
    puts(b)
    n = n - 1
  end
end

fibonaccit( 10 )
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}, {:call_site=>{:name=>"fibonaccit"}, :argument_list=>[{:argument=>{:integer=>"10"}}]}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "fibonaccit"), [s(:field, :int, :n)], [s(:assign, s(:name, "a"), s(:int, 0)), s(:assign, s(:name, "b"), s(:int, 1)), s(:while, s(:operator, ">", s(:name, "n"), s(:int, 1)), [s(:assign, s(:name, "tmp"), s(:name, "a")), s(:assign, s(:name, "a"), s(:name, "b")), s(:assign, s(:name, "b"), s(:operator, "+", s(:name, "tmp"), s(:name, "b"))), s(:call, s(:name, "puts"), [s(:name, "b")]), s(:assign, s(:name, "n"), s(:operator, "-", s(:name, "n"), s(:int, 1)))])]), s(:call, s(:name, "fibonaccit"), [s(:int, 10)])])
  end

  def test_module_method
    @string_input = <<HERE
module Fibo
  int fibonaccit(int n)
    int a = 0
    return a
  end

  fibonaccit( 10 )
end

HERE
    @parse_output = {:expression_list=>[{:module_name=>"Fibo", :module_expressions=>[{:type=>"int", :function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:name=>"int"}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:return=>"return", :return_expression=>{:name=>"a"}}], :end=>"end"}, {:call_site=>{:name=>"fibonaccit"}, :argument_list=>[{:argument=>{:integer=>"10"}}]}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Fibo", [s(:function, :int, s(:name, "fibonaccit"), [s(:field, :int, :n)], [s(:name, "int"), s(:assign, s(:name, "a"), s(:int, 0)), s(:return, s(:name, "a"))]), s(:call, s(:name, "fibonaccit"), [s(:int, 10)])])])
  end

  def test_module_assignment
    @string_input = <<HERE
module Fibo
  a = 5 + foo
  bar( b , a , r)
end

HERE
    @parse_output = {:expression_list=>[{:module_name=>"Fibo", :module_expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:l=>{:integer=>"5"}, :o=>"+ ", :r=>{:name=>"foo"}}}, {:call_site=>{:name=>"bar"}, :argument_list=>[{:argument=>{:name=>"b"}}, {:argument=>{:name=>"a"}}, {:argument=>{:name=>"r"}}]}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Fibo", [s(:assign, s(:name, "a"), s(:operator, "+", s(:int, 5), s(:name, "foo"))), s(:call, s(:name, "bar"), [s(:name, "b"), s(:name, "a"), s(:name, "r")])])])
  end

  def test_root_module_class
    @string_input = <<HERE
module FooBo
  class Bar
    a = 5 + foo
  end
end

HERE
    @parse_output = {:expression_list=>[{:module_name=>"FooBo", :module_expressions=>[{:module_name=>"Bar", :derived_name=>nil, :class_expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:l=>{:integer=>"5"}, :o=>"+ ", :r=>{:name=>"foo"}}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "FooBo", [s(:class, "Bar", nil, [s(:assign, s(:name, "a"), s(:operator, "+", s(:int, 5), s(:name, "foo")))])])])
  end

  def test_class_method
    @string_input = <<HERE
class FooBo
  Bar.call(35)
end

HERE
    @parse_output = {:expression_list=>[{:module_name=>"FooBo", :derived_name=>nil, :class_expressions=>[{:receiver=>{:module_name=>"Bar"}, :call_site=>{:name=>"call"}, :argument_list=>[{:argument=>{:integer=>"35"}}]}], :end=>"end"}]}
    @transform_output = s(:list, [s(:class, "FooBo", nil, [s(:call, s(:name, "call"), [s(:int, 35)], s(:module, "Bar"))])])
  end

end
