require_relative "../parser_helper"

class TestCompound < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_one_array
    @input    = '[42]'
    @parse_output = {:array_constant=>[{:array_element=>{:integer=>"42"}}]}
    @output =  Ast::ArrayExpression.new([Ast::IntegerExpression.new(42)])
    @root = :array_constant
  end

  def test_array_list
    @input    = '[42, foo]'
    @parse_output = {:array_constant=>[{:array_element=>{:integer=>"42"}}, {:array_element=>{:name=>"foo"}}]}
    @output = Ast::ArrayExpression.new([Ast::IntegerExpression.new(42), Ast::NameExpression.new("foo")])
    @root = :array_constant
  end

  def test_array_list2
    @input    = '[42, nil]'
    @parse_output = {:array_constant=>[{:array_element=>{:integer=>"42"}}, {:array_element=>{:nil=>"nil"}}]}
    @output = Ast::ArrayExpression.new([Ast::IntegerExpression.new(42), Ast::NilExpression.new()])
    @root = :array_constant
  end

  def test_array_ops
    @input    = '[ 3 + 4 , foo(22) ]'
    @parse_output = {:array_constant=>[{:array_element=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"4"}}}, {:array_element=>{:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"22"}}]}}]}
    @output = Ast::ArrayExpression.new(
            [Ast::OperatorExpression.new("+", Ast::IntegerExpression.new(3),Ast::IntegerExpression.new(4)), 
              Ast::CallSiteExpression.new("foo", [Ast::IntegerExpression.new(22)] )])
    @root = :array_constant
  end

  def test_hash
    @input = '{ foo => 33 }'
    @parse_output = {:hash_constant=>[{:hash_pair=>{:hash_key=>{:name=>"foo"}, :hash_value=>{:integer=>"33"}}}]}
    @output = Ast::HashExpression.new([Ast::AssociationExpression.new(Ast::NameExpression.new("foo") , Ast::IntegerExpression.new(33))])
    @root = :hash_constant
  end

  def test_hash_list
    @input = "{foo => 33 , bar => 42}"
    @parse_output = {:hash_constant=>[{:hash_pair=>{:hash_key=>{:name=>"foo"}, :hash_value=>{:integer=>"33"}}}, {:hash_pair=>{:hash_key=>{:name=>"bar"}, :hash_value=>{:integer=>"42"}}}]}
    @output = Ast::HashExpression.new([Ast::AssociationExpression.new(Ast::NameExpression.new("foo") , Ast::IntegerExpression.new(33)),Ast::AssociationExpression.new(Ast::NameExpression.new("bar") , Ast::IntegerExpression.new(42))])
    @root = :hash_constant
  end

end