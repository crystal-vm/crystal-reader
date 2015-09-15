require_relative "../parser_helper"

class RootTestWhile < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_while
    @string_input = <<HERE
while(1)
  tmp = a
  puts(b)
end
HERE
    @parse_output = {:expression_list=>[{:while=>"while", :while_cond=>{:integer=>"1"}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:while, s(:int, 1), [s(:assign, s(:name, "tmp"), s(:name, "a")), s(:call, s(:name, "puts"), [s(:name, "b")])])])
  end

  def test_while_method
    @string_input = <<HERE
while(1)
  tmp = String.new()
  tmp.puts(i)
end
HERE
    @parse_output = {:expression_list=>[{:while=>"while", :while_cond=>{:integer=>"1"}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:receiver=>{:module_name=>"String"}, :call_site=>{:name=>"new"}, :argument_list=>[]}}, {:receiver=>{:name=>"tmp"}, :call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"i"}}]}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:while, s(:int, 1), [s(:assign, s(:name, "tmp"), s(:call, s(:name, "new"), [], s(:module, "String"))), s(:call, s(:name, "puts"), [s(:name, "i")], s(:name, "tmp"))])])
  end

  def test_big_while
    @string_input = <<HERE
while( n > 1)
  tmp = a
  a = b
  b = tmp + b
  puts(b)
  n = n - 1
end
HERE
    @parse_output = {:expression_list=>[{:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}]}
    @transform_output = s(:list, [s(:while, s(:operator, ">", s(:name, "n"), s(:int, 1)), [s(:assign, s(:name, "tmp"), s(:name, "a")), s(:assign, s(:name, "a"), s(:name, "b")), s(:assign, s(:name, "b"), s(:operator, "+", s(:name, "tmp"), s(:name, "b"))), s(:call, s(:name, "puts"), [s(:name, "b")]), s(:assign, s(:name, "n"), s(:operator, "-", s(:name, "n"), s(:int, 1)))])])
  end
end
