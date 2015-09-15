require_relative "../parser_helper"

class TestCallSite < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_single_argument
    @string_input = 'foo(42)'
    @parse_output = {:call_site => {:name => 'foo'},
             :argument_list    => [{:argument => {:integer => '42'} }] }
    @transform_output = s(:call, s(:name, "foo"), [s(:int, 42)])
    @parser = @parser.call_site
  end

  def test_single_self
    @string_input = 'self.foo(42)'
    @parse_output = {:receiver=>{:name=>"self"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @transform_output = s(:call, s(:name, "foo"), [s(:int, 42)], s(:name, "self"))
    @parser = @parser.call_site
  end


  def test_single_name
    @string_input = 'my_my.foo(42)'
    @parse_output = {:receiver=>{:name=>"my_my"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @transform_output = s(:call, s(:name, "foo"), [s(:int, 42)], s(:name, "my_my"))
    @parser = @parser.call_site
  end

  def test_int_receiver
    @string_input = '42.put()'
    @parse_output = {:receiver=>{:integer=>"42"}, :call_site=>{:name=>"put"}, :argument_list=>[]}
    @transform_output = s(:call, s(:name, "put"), [], s(:int, 42))
    @parser = @parser.call_site
  end

  def test_string_receiver
    @string_input = '"hello".puts()'
    @parse_output = {:receiver=>{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}, :call_site=>{:name=>"puts"}, :argument_list=>[]}
    @transform_output = s(:call, s(:name, "puts"), [], s(:string, "hello"))
    @parser = @parser.call_site
  end

  def test_single_class
    @string_input = 'Object.foo(42)'
    @parse_output = {:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @transform_output = s(:call, s(:name, "foo"), [s(:int, 42)], s(:module, "Object"))
    @parser = @parser.call_site
  end

  def test_call_site_multi
    @string_input = 'baz(42, foo)'
    @parse_output = {:call_site => {:name => 'baz' },
                     :argument_list    => [{:argument => {:integer => '42'}},
                                           {:argument => {:name => 'foo'}}]}
    @transform_output = s(:call, s(:name, "baz"), [s(:int, 42), s(:name, "foo")])
    @parser = @parser.call_site
  end

  def test_call_site_string
    @string_input    = 'puts( "hello")'
    @parse_output = {:call_site => {:name => 'puts' },
                      :argument_list    => [{:argument =>
                        {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}}]}
    @transform_output = s(:call, s(:name, "puts"), [s(:string, "hello")])
    @parser = @parser.call_site
  end

  def test_call_operator
    @string_input    = 'puts( 3 + 5)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}]}
    @transform_output = s(:call, s(:name, "puts"), [s(:operator, "+", s(:int, 3), s(:int, 5))])
    @parser = @parser.call_site
  end

  def test_call_two_operators
    @string_input    = 'puts(3 + 5 , a - 3)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}, {:argument=>{:l=>{:name=>"a"}, :o=>"- ", :r=>{:integer=>"3"}}}]}
    @transform_output = s(:call, s(:name, "puts"), [s(:operator, "+", s(:int, 3), s(:int, 5)), s(:operator, "-", s(:name, "a"), s(:int, 3))])
    @parser = @parser.call_site
  end

  def test_call_chaining
    @string_input    = 'puts(putint(3 + 5 ), a - 3)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:call_site=>{:name=>"putint"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}]}}, {:argument=>{:l=>{:name=>"a"}, :o=>"- ", :r=>{:integer=>"3"}}}]}
    @transform_output = s(:call, s(:name, "puts"), [s(:call, s(:name, "putint"), [s(:operator, "+", s(:int, 3), s(:int, 5))]), s(:operator, "-", s(:name, "a"), s(:int, 3))])
    @parser = @parser.call_site
  end

  def test_call_chaining_name
    @string_input    = 'puts(name.putint(4), a)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:receiver=>{:name=>"name"}, :call_site=>{:name=>"putint"}, :argument_list=>[{:argument=>{:integer=>"4"}}]}}, {:argument=>{:name=>"a"}}]}
    @transform_output = s(:call, s(:name, "puts"), [s(:call, s(:name, "putint"), [s(:int, 4)], s(:name, "name")), s(:name, "a")])
    @parser = @parser.call_site
  end

  def test_call_chaining_class
    @string_input    = 'Class.new(self.get(4))'
    @parse_output = {:receiver=>{:module_name=>"Class"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:receiver=>{:name=>"self"}, :call_site=>{:name=>"get"}, :argument_list=>[{:argument=>{:integer=>"4"}}]}}]}
    @transform_output = s(:call, s(:name, "new"), [s(:call, s(:name, "get"), [s(:int, 4)], s(:name, "self"))], s(:module, "Class"))
    @parser = @parser.call_site
  end

end
