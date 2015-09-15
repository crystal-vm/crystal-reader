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
    @transform_output = s(:list, [s(:module, "Simple", [s(:int, 5)])])
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
    @transform_output = s(:list, [s(:module, "Opers", [s(:function, s(:name, "foo"), [s(:name, "x")], [s(:assign, s(:name, "abba"), s(:int, 5)), s(:operator, "+", s(:int, 2), s(:int, 5))])])])
  end

  def test_module_assign_var
    @string_input    = <<HERE
module Opers
  abba = 5
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Opers", :module_expressions=>[{:l=>{:name=>"abba"}, :o=>"= ", :r=>{:integer=>"5"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Opers", [s(:assign, s(:name, "abba"), s(:int, 5))])])
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
    @transform_output = s(:list, [s(:module, "Foo", [s(:function, s(:name, "ofthen"), [s(:name, "n")], [s(:if, s(:int, 0), [s(:assign, s(:name, "isit"), s(:int, 42))], [s(:assign, s(:name, "maybenot"), s(:int, 667))])])])])
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
    @transform_output = s(:list, [s(:module, "Soho", [s(:call, s(:name, "ofthen"), [s(:operator, "+", s(:int, 3), s(:int, 4)), s(:name, "var")]), s(:function, s(:name, "ofthen"), [s(:name, "n"), s(:name, "m")], [s(:int, 44)])])])
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
    @transform_output = s(:list, [s(:class, "Foo", nil, [s(:function, s(:name, "bar"), [], [s(:int, 4)])])])
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
    @transform_output = s(:list, [s(:module, "Foo", [s(:class, "Bar", nil, [s(:call, s(:name, "funcall"), [s(:operator, "+", s(:int, 3), s(:int, 4)), s(:name, "var")])])])])
  end
end
