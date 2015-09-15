require_relative "../parser_helper"

class TestCallSite < MiniTest::Test
  include ParserHelper

  def test_single_self
    @input = 'self.foo(42)'
    @output = s(:call, s(:field , "self" , "foo") , [s(:int, 42)])
    check :call_site
  end

  def test_single_name
    @input = 'my_my.foo(42)'
    @parse_output = {:receiver=>{:name=>"my_my"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = s(:call, s(:field, "my_my", "foo"), [s(:int, 42)])
    check :call_site
  end

  def test_int_receiver
    @input = '42.put()'
    @output = s(:call, s(:field, s(:int , 42) ,  "put") , [])
    check :call_site
  end

  def test_string_receiver
    @input = '"hello".puts()'
    @output = s(:call , s(:field , s(:string , "hello") , "puts") , [])
    check :call_site
  end

  def test_call_site_2
    @input = 'self.baz(42, foo)'
    @output = s(:call ,s(:field , "self", "baz") ,  [s(:int, 42), "foo"])
    check :call_site
  end

  def test_call_site_3
    @input = 'self.baz(42, foo , bar)'
    @output = s(:call,  s(:field, "self", "baz"), [s(:int, 42), "foo", "bar"])
    check :call_site
  end

end
