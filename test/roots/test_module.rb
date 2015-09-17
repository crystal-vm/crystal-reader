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
  int foo(int x)
    int abba = 5
    return abba + 5
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Opers", :module_expressions=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"x"}}], :expressions=>[{:name=>"int"}, {:l=>{:name=>"abba"}, :o=>"= ", :r=>{:integer=>"5"}}, {:return=>"return", :return_expression=>{:l=>{:name=>"abba"}, :o=>"+ ", :r=>{:integer=>"5"}}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Opers", [s(:function, :int, s(:name, "foo"), [s(:field, :int, :x)], [s(:name, "int"), s(:assign, s(:name, "abba"), s(:int, 5)), s(:return, s(:operator, "+", s(:name, "abba"), s(:int, 5)))])])])
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
  ref ofthen(int n)
    if(0)
      isit = 42
    else
      maybenot = 667
    end
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Foo", :module_expressions=>[{:type=>"ref", :function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:l=>{:name=>"isit"}, :o=>"= ", :r=>{:integer=>"42"}}], :else=>"else"}, :if_false=>{:expressions=>[{:l=>{:name=>"maybenot"}, :o=>"= ", :r=>{:integer=>"667"}}], :end=>"end"}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Foo", [s(:function, :ref, s(:name, "ofthen"), [s(:field, :int, :n)], [s(:if, s(:int, 0), [s(:assign, s(:name, "isit"), s(:int, 42))], [s(:assign, s(:name, "maybenot"), s(:int, 667))])])])])
  end

  def test_module_function
    @string_input    = <<HERE
module Soho
  ofthen(3+4 , var)
  int ofthen(int n,ref m )
    return 44
  end
end
HERE
    @parse_output = {:expression_list=>[{:module_name=>"Soho", :module_expressions=>[{:call_site=>{:name=>"ofthen"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+", :r=>{:integer=>"4"}}}, {:argument=>{:name=>"var"}}]}, {:type=>"int", :function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}, {:parameter=>{:type=>"ref", :name=>"m"}}], :expressions=>[{:return=>"return", :return_expression=>{:integer=>"44"}}], :end=>"end"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:module, "Soho", [s(:call, s(:name, "ofthen"), [s(:operator, "+", s(:int, 3), s(:int, 4)), s(:name, "var")]), s(:function, :int, s(:name, "ofthen"), [s(:field, :int, :n), s(:field, :ref, :m)], [s(:return, s(:int, 44))])])])
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
