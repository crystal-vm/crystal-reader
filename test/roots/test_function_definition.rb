require_relative "../parser_helper"

class RootTestFunctionDefinition < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_simplest_function
    @string_input    = <<HERE
int foo(ref x)
  5
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:type=>"ref", :name=>"x"}}], :expressions=>[{:integer=>"5"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "foo"), [s(:field, :ref, :x)], [s(:int, 5)])])
  end

  def test_function_no_arg
    @string_input    = <<HERE
int foo()
  5
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[], :expressions=>[{:integer=>"5"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "foo"), [], [s(:int, 5)])])
  end

  def test_function_two_args
    @string_input    = <<HERE
int foo( int n ,ref  m)
  n
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}, {:parameter=>{:type=>"ref", :name=>"m"}}], :expressions=>[{:name=>"n"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "foo"), [s(:field, :int, :n), s(:field, :ref, :m)], [s(:name, "n")])])
  end

  def test_class_function
    @string_input    = <<HERE
int  String.length( ref x )
  length
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :receiver=>{:module_name=>"String"}, :function_name=>{:name=>"length"}, :parameter_list=>[{:parameter=>{:type=>"ref", :name=>"x"}}], :expressions=>[{:name=>"length"}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "length"), [s(:field, :ref, :x)], [s(:name, "length")], s(:module, "String"))])
  end

  def test_function_ops
    @string_input    = <<HERE
int foo(int x)
 int abba = 5
 abba + 5
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"x"}}], :expressions=>[{:name=>"int"}, {:l=>{:name=>"abba"}, :o=>"= ", :r=>{:integer=>"5"}}, {:l=>{:name=>"abba"}, :o=>"+ ", :r=>{:integer=>"5"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "foo"), [s(:field, :int, :x)], [s(:name, "int"), s(:assign, s(:name, "abba"), s(:int, 5)), s(:operator, "+", s(:name, "abba"), s(:int, 5))])])
  end

  def test_function_if
    @string_input    = <<HERE
ref ofthen(int n)
  if(0)
    isit = 42
  else
    maybenot = 667
  end
end
HERE
    @parse_output = {:expression_list=>[{:type=>"ref", :function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:l=>{:name=>"isit"}, :o=>"= ", :r=>{:integer=>"42"}}], :else=>"else"}, :if_false=>{:expressions=>[{:l=>{:name=>"maybenot"}, :o=>"= ", :r=>{:integer=>"667"}}], :end=>"end"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :ref, s(:name, "ofthen"), [s(:field, :int, :n)], [s(:if, s(:int, 0), [s(:assign, s(:name, "isit"), s(:int, 42))], [s(:assign, s(:name, "maybenot"), s(:int, 667))])])])
  end

  def test_function_return
    @string_input    = <<HERE
int retvar(ref n)
  int i = 5
  return i
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:type=>"ref", :name=>"n"}}], :expressions=>[{:name=>"int"}, {:l=>{:name=>"i"}, :o=>"= ", :r=>{:integer=>"5"}}, {:return=>"return", :return_expression=>{:name=>"i"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "retvar"), [s(:field, :ref, :n)], [s(:name, "int"), s(:assign, s(:name, "i"), s(:int, 5)), s(:return, s(:name, "i"))])])
  end

  def test_function_return_if
    @string_input    = <<HERE
int retvar(int n)
  if( n > 5)
    return 10
  else
    return 20
  end
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"5"}}, :if_true=>{:expressions=>[{:return=>"return", :return_expression=>{:integer=>"10"}}], :else=>"else"}, :if_false=>{:expressions=>[{:return=>"return", :return_expression=>{:integer=>"20"}}], :end=>"end"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "retvar"), [s(:field, :int, :n)], [s(:if, s(:operator, ">", s(:name, "n"), s(:int, 5)), [s(:return, s(:int, 10))], [s(:return, s(:int, 20))])])])
  end

  def test_function_return_while
    @string_input    = <<HERE
int retvar(int n )
  while( n > 5)
    n = n + 1
    return n
  end
end
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"5"}}, :body=>{:expressions=>[{:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"+ ", :r=>{:integer=>"1"}}}, {:return=>"return", :return_expression=>{:name=>"n"}}], :end=>"end"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "retvar"), [s(:field, :int, :n)], [s(:while, s(:operator, ">", s(:name, "n"), s(:int, 5)), [s(:assign, s(:name, "n"), s(:operator, "+", s(:name, "n"), s(:int, 1))), s(:return, s(:name, "n"))])])])
  end

  def test_function_while
    @string_input    = <<HERE
ref fibonaccit(int n)
  a = 0
  while(n)
    some = 43
    other = some * 4
  end
end
HERE
    @parse_output = {:expression_list=>[{:type=>"ref", :function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:while=>"while", :while_cond=>{:name=>"n"}, :body=>{:expressions=>[{:l=>{:name=>"some"}, :o=>"= ", :r=>{:integer=>"43"}}, {:l=>{:name=>"other"}, :o=>"= ", :r=>{:l=>{:name=>"some"}, :o=>"* ", :r=>{:integer=>"4"}}}], :end=>"end"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :ref, s(:name, "fibonaccit"), [s(:field, :int, :n)], [s(:assign, s(:name, "a"), s(:int, 0)), s(:while, s(:name, "n"), [s(:assign, s(:name, "some"), s(:int, 43)), s(:assign, s(:name, "other"), s(:operator, "*", s(:name, "some"), s(:int, 4)))])])])
  end

  def test_function_big_while
    @string_input    = <<HERE
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
HERE
    @parse_output = {:expression_list=>[{:type=>"int", :function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:type=>"int", :name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}]}
    @transform_output = s(:list, [s(:function, :int, s(:name, "fibonaccit"), [s(:field, :int, :n)], [s(:assign, s(:name, "a"), s(:int, 0)), s(:assign, s(:name, "b"), s(:int, 1)), s(:while, s(:operator, ">", s(:name, "n"), s(:int, 1)), [s(:assign, s(:name, "tmp"), s(:name, "a")), s(:assign, s(:name, "a"), s(:name, "b")), s(:assign, s(:name, "b"), s(:operator, "+", s(:name, "tmp"), s(:name, "b"))), s(:call, s(:name, "puts"), [s(:name, "b")]), s(:assign, s(:name, "n"), s(:operator, "-", s(:name, "n"), s(:int, 1)))])])])
  end
end
