require_relative "../parser_helper"

class TestCallSite < MiniTest::Test
  include ParserHelper

  def test_single_self
    @input = 'self.foo(42)'
    @output = Ast::CallSiteExpression.new :foo, [Ast::IntegerExpression.new(42)]
    check :call_site
  end

  def test_single_name
    @input = 'my_my.foo(42)'
    @parse_output = {:receiver=>{:name=>"my_my"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(42)] ,Ast::NameExpression.new("my_my"))
    check :call_site
  end

  def test_int_receiver
    @input = '42.put()'
    @output = Ast::CallSiteExpression.new(:put, [] ,Ast::IntegerExpression.new(42))
    check :call_site
  end

  def test_string_receiver
    @input = '"hello".puts()'
    @output = Ast::CallSiteExpression.new(:puts, [] ,Ast::StringExpression.new("hello"))
    check :call_site
  end

  def test_call_site_2
    @input = 'self.baz(42, foo)'
    @output = Ast::CallSiteExpression.new :baz,
                           [Ast::IntegerExpression.new(42), Ast::NameExpression.new("foo") ] ,
                           Ast::NameExpression.new(:self)
    check :call_site
  end

  def test_call_site_3
    @input = 'self.baz(42, foo , bar)'
    @output = Ast::CallSiteExpression.new :baz,
                           [Ast::IntegerExpression.new(42) ,
                               Ast::NameExpression.new("foo") ,
                               Ast::NameExpression.new("bar")] ,
                           Ast::NameExpression.new(:self)
    check :call_site
  end

end
