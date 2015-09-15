require_relative "../parser_helper"

class TestFunctionDefinition < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_simplest_function
    @string_input    = <<HERE
def foo(x)
  5
end
HERE
    @parse_output = {:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:integer=>"5"}], :end=>"end"}
    @transform_output = s(:function, s(:name, "foo"), [s(:name, "x")], [s(:int, 5)])
    @parser = @parser.function_definition
  end

  def test_class_function
    @string_input    = <<HERE
def String.length(x)
  length
end
HERE
    @parse_output = {:receiver=>{:module_name=>"String"}, :function_name=>{:name=>"length"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:name=>"length"}], :end=>"end"}
    @transform_output = s(:function, s(:name, "length"), [s(:name, "x")], [s(:name, "length")], s(:module, "String"))
    @parser = @parser.function_definition
  end

  def test_function_ops
    @string_input    = <<HERE
def foo(x)
 abba = 5
 2 + 5
end
HERE
    @parse_output = {:function_name=>{:name=>"foo"}, :parameter_list=>[{:parameter=>{:name=>"x"}}], :expressions=>[{:l=>{:name=>"abba"}, :o=>"= ", :r=>{:integer=>"5"}}, {:l=>{:integer=>"2"}, :o=>"+ ", :r=>{:integer=>"5"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "foo"), [s(:name, "x")], [s(:assign, s(:name, "abba"), s(:int, 5)), s(:operator, "+", s(:int, 2), s(:int, 5))])
    @parser = @parser.function_definition
  end

  def test_function_if
    @string_input    = <<HERE
def ofthen(n)
  if(0)
    isit = 42
  else
    maybenot = 667
  end
end
HERE
    @parse_output = {:function_name=>{:name=>"ofthen"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:l=>{:name=>"isit"}, :o=>"= ", :r=>{:integer=>"42"}}], :else=>"else"}, :if_false=>{:expressions=>[{:l=>{:name=>"maybenot"}, :o=>"= ", :r=>{:integer=>"667"}}], :end=>"end"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "ofthen"), [s(:name, "n")], [s(:if, s(:int, 0), [s(:assign, s(:name, "isit"), s(:int, 42))], [s(:assign, s(:name, "maybenot"), s(:int, 667))])])
    @parser = @parser.function_definition
  end

  def test_function_return
    @string_input    = <<HERE
def retvar(n)
  i = 5
  return i
end
HERE
    @parse_output = {:function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:l=>{:name=>"i"}, :o=>"= ", :r=>{:integer=>"5"}}, {:return=>"return", :return_expression=>{:name=>"i"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "retvar"), [s(:name, "n")], [s(:assign, s(:name, "i"), s(:int, 5)), s(:return, s(:name, "i"))])
    @parser = @parser.function_definition
  end

  def test_function_return_if
    @string_input    = <<HERE
def retvar(n)
  if( n > 5)
    return 10
  else
    return 20
  end
end
HERE
    @parse_output = {:function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:if=>"if", :conditional=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"5"}}, :if_true=>{:expressions=>[{:return=>"return", :return_expression=>{:integer=>"10"}}], :else=>"else"}, :if_false=>{:expressions=>[{:return=>"return", :return_expression=>{:integer=>"20"}}], :end=>"end"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "retvar"), [s(:name, "n")], [s(:if, s(:operator, ">", s(:name, "n"), s(:int, 5)), [s(:return, s(:int, 10))], [s(:return, s(:int, 20))])])
    @parser = @parser.function_definition
  end

  def test_function_return_while
    @string_input    = <<HERE
def retvar(n)
  while( n > 5)
    n = n + 1
    return n
  end
end
HERE
    @parse_output = {:function_name=>{:name=>"retvar"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"5"}}, :body=>{:expressions=>[{:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"+ ", :r=>{:integer=>"1"}}}, {:return=>"return", :return_expression=>{:name=>"n"}}], :end=>"end"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "retvar"), [s(:name, "n")], [s(:while, s(:operator, ">", s(:name, "n"), s(:int, 5)), [s(:assign, s(:name, "n"), s(:operator, "+", s(:name, "n"), s(:int, 1))), s(:return, s(:name, "n"))])])
    @parser = @parser.function_definition
  end

  def test_function_while
    @string_input    = <<HERE
def fibonaccit(n)
  a = 0
  while(n)
    some = 43
    other = some * 4
  end
end
HERE
    @parse_output = {:function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:while=>"while", :while_cond=>{:name=>"n"}, :body=>{:expressions=>[{:l=>{:name=>"some"}, :o=>"= ", :r=>{:integer=>"43"}}, {:l=>{:name=>"other"}, :o=>"= ", :r=>{:l=>{:name=>"some"}, :o=>"* ", :r=>{:integer=>"4"}}}], :end=>"end"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "fibonaccit"), [s(:name, "n")], [s(:assign, s(:name, "a"), s(:int, 0)), s(:while, s(:name, "n"), [s(:assign, s(:name, "some"), s(:int, 43)), s(:assign, s(:name, "other"), s(:operator, "*", s(:name, "some"), s(:int, 4)))])])
    @parser = @parser.function_definition
  end

  def test_function_big_while
    @string_input    = <<HERE
def fibonaccit(n)
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
    @parse_output = {:function_name=>{:name=>"fibonaccit"}, :parameter_list=>[{:parameter=>{:name=>"n"}}], :expressions=>[{:l=>{:name=>"a"}, :o=>"= ", :r=>{:integer=>"0"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:integer=>"1"}}, {:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}], :end=>"end"}
    @transform_output = s(:function, s(:name, "fibonaccit"), [s(:name, "n")], [s(:assign, s(:name, "a"), s(:int, 0)), s(:assign, s(:name, "b"), s(:int, 1)), s(:while, s(:operator, ">", s(:name, "n"), s(:int, 1)), [s(:assign, s(:name, "tmp"), s(:name, "a")), s(:assign, s(:name, "a"), s(:name, "b")), s(:assign, s(:name, "b"), s(:operator, "+", s(:name, "tmp"), s(:name, "b"))), s(:call, s(:name, "puts"), [s(:name, "b")]), s(:assign, s(:name, "n"), s(:operator, "-", s(:name, "n"), s(:int, 1)))])])
    @parser = @parser.function_definition
  end
end
