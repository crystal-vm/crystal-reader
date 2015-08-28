require_relative "../parser_helper"

class TestCallSite < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_single_argument
    @input = 'foo(42)'
    @parse_output = {:call_site => {:name => 'foo'},
             :argument_list    => [{:argument => {:integer => '42'} }] }
    @output = Ast::CallSiteExpression.new :foo, [Ast::IntegerExpression.new(42)]
    @root = :call_site
  end

  def test_single_self
    @input = 'self.foo(42)'
    @parse_output = {:receiver=>{:name=>"self"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new :foo, [Ast::IntegerExpression.new(42)]
    @root = :call_site
  end

  def test_single_instance
    @input = '@var.foo(42)'
    @parse_output = {:receiver=>{:instance_variable=>{:name=>"var"}}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(42)] ,Ast::VariableExpression.new(:var))
    @root = :call_site
  end

  def test_single_name
    @input = 'my_my.foo(42)'
    @parse_output = {:receiver=>{:name=>"my_my"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(42)] ,Ast::NameExpression.new("my_my"))
    @root = :call_site
  end

  def test_int_receiver
    @input = '42.put()'
    @parse_output = {:receiver=>{:integer=>"42"}, :call_site=>{:name=>"put"}, :argument_list=>[]}
    @output = Ast::CallSiteExpression.new(:put, [] ,Ast::IntegerExpression.new(42))
    @root = :call_site
  end

  def test_string_receiver
    @input = '"hello".puts()'
    @parse_output = {:receiver=>{:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}, :call_site=>{:name=>"puts"}, :argument_list=>[]}
    @output = Ast::CallSiteExpression.new(:puts, [] ,Ast::StringExpression.new("hello"))
    @root = :call_site
  end

  def test_single_class
    @input = 'Object.foo(42)'
    @parse_output = {:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"42"}}]}
    @output = Ast::CallSiteExpression.new(:foo, [Ast::IntegerExpression.new(42)] ,Ast::ModuleName.new("Object"))
    @root = :call_site
  end

  def test_call_site_multi
    @input = 'baz(42, foo)'
    @parse_output = {:call_site => {:name => 'baz' },
                     :argument_list    => [{:argument => {:integer => '42'}},
                                           {:argument => {:name => 'foo'}}]}
    @output = Ast::CallSiteExpression.new :baz, 
                           [Ast::IntegerExpression.new(42), Ast::NameExpression.new("foo") ]
    @root = :call_site
  end

  def test_call_site_string
    @input    = 'puts( "hello")'
    @parse_output = {:call_site => {:name => 'puts' },
                      :argument_list    => [{:argument => 
                        {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}}]}
    @output = Ast::CallSiteExpression.new "puts", [Ast::StringExpression.new("hello")]
    @root = :call_site
  end

  def test_call_operator
    @input    = 'puts( 3 + 5)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}]}
    @output = Ast::CallSiteExpression.new(:puts, [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(5))] )
    @root = :call_site
  end

  def test_call_two_operators
    @input    = 'puts(3 + 5 , a - 3)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}, {:argument=>{:l=>{:name=>"a"}, :o=>"- ", :r=>{:integer=>"3"}}}]}
    @output = Ast::CallSiteExpression.new(:puts, [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(5)),Ast::OperatorExpression.new("-", Ast::NameExpression.new("a"),Ast::IntegerExpression.new(3))] )
    @root = :call_site
  end

  def test_call_chaining
    @input    = 'puts(putint(3 + 5 ), a - 3)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:call_site=>{:name=>"putint"}, :argument_list=>[{:argument=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"5"}}}]}}, {:argument=>{:l=>{:name=>"a"}, :o=>"- ", :r=>{:integer=>"3"}}}]}
    @output = Ast::CallSiteExpression.new(:puts, [Ast::CallSiteExpression.new(:putint, [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(5))] ),Ast::OperatorExpression.new("-", Ast::NameExpression.new("a"),Ast::IntegerExpression.new(3))] )
    @root = :call_site
  end

  def test_call_chaining_name
    @input    = 'puts(name.putint(4), a)'
    @parse_output = {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:receiver=>{:name=>"name"}, :call_site=>{:name=>"putint"}, :argument_list=>[{:argument=>{:integer=>"4"}}]}}, {:argument=>{:name=>"a"}}]}
    @output = Ast::CallSiteExpression.new(:puts, [Ast::CallSiteExpression.new(:putint, [Ast::IntegerExpression.new(4)] ,Ast::NameExpression.new("name")),Ast::NameExpression.new("a")] ,Ast::NameExpression.new("self"))
    @root = :call_site
  end

  def test_call_chaining_class
    @input    = 'Class.new(self.get(4))'
    @parse_output = {:receiver=>{:module_name=>"Class"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:receiver=>{:name=>"self"}, :call_site=>{:name=>"get"}, :argument_list=>[{:argument=>{:integer=>"4"}}]}}]}
    @output = Ast::CallSiteExpression.new(:new, [Ast::CallSiteExpression.new(:get, [Ast::IntegerExpression.new(4)] ,Ast::NameExpression.new("self"))] ,Ast::ModuleName.new("Class"))
    @root = :call_site
  end
  def test_call_chaining_instance
    @input    = '@class.new(self.get(4))'
    @parse_output = {:receiver=>{:instance_variable=>{:name=>"class"}}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:receiver=>{:name=>"self"}, :call_site=>{:name=>"get"}, :argument_list=>[{:argument=>{:integer=>"4"}}]}}]}
    @output = Ast::CallSiteExpression.new(:new, [Ast::CallSiteExpression.new(:get, [Ast::IntegerExpression.new(4)] ,Ast::NameExpression.new("self"))] ,Ast::VariableExpression.new(:class))
    @root = :call_site
  end

end