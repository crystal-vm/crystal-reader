require_relative "../parser_helper"

class TestCallSite < MiniTest::Test

  def setup
    @parser = Expression
  end
  def check
    parse    = @parser.parse(@input)
    assert_equal @input , parse
    assert_equal @output , parse.value
  end

  def test_single_self
    @input = 'self.foo(42)'
    @output = Ast::CallSiteExpression.new :foo, [Ast::IntegerExpression.new(42)]
    check
  end

  def test_single_name
    @input = 'my_my.foo(42)'
    @parse_output = {:receiver=>{:name=>"my_my"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(42)] ,Ast::NameExpression.new("my_my"))
    check
  end

  def test_int_receiver
    @input = '42.put()'
    @output = Ast::CallSiteExpression.new(:put, [] ,Ast::IntegerExpression.new(42))
    check
  end

  def test_string_receiver
    @input = '"hello".puts()'
    @output = Ast::CallSiteExpression.new(:puts, [] ,Ast::StringExpression.new("hello"))
    check
  end

  def test_call_site_multi
    @input = 'self.baz(42, foo)'
    @output = Ast::CallSiteExpression.new :baz,
                           [Ast::IntegerExpression.new(42), Ast::NameExpression.new("foo") ] ,
                           Ast::NameExpression.new(:self)
    check
  end

end
