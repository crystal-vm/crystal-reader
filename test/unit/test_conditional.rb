require_relative "../parser_helper"

class TestConditional < MiniTest::Test
  include ParserHelper

  def test_assignment
    @input = "myvar = 42"
    @output = Ast::AssignmentExpression.new(:myvar,Ast::IntegerExpression.new(42))
    check :assignment
  end

  def test_variable_declaration
    @input = "int myvar"
    @output = Ast::VariableDefinition.new(:int,:myvar,nil)
    check :variable_definition
  end

  def test_variable_declaration_value
    @input = "int myvar = 42"
    @output = Ast::VariableDefinition.new(:int,:myvar,Ast::IntegerExpression.new(42))
    check :variable_definition
  end

  def test_if
    @input = <<HERE
if( 1 )
  int num = 42
end
HERE
    @output = Ast::IfExpression.new(Ast::IntegerExpression.new(1), [Ast::VariableDefinition.new(:int,:num,Ast::IntegerExpression.new(42))],nil )
    check :conditional
  end

  def ttest_conditional_with_calls
    @input = <<HERE
if(var)

end
HERE
    @output = Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new("var")), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new("Object"))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new("var"))] )
    check
  end

  def ttest_conditional_nil
    @input = <<HERE
if(3 == nil)
  3
else
4
end
HERE
    @input.chop!
    @parse_output = {:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"== ", :r=>{:nil=>"nil"}}, :if_true=>{:expressions=>[{:integer=>"3"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"4"}], :end=>"end"}}
    @output = Ast::IfExpression.new(Ast::OperatorExpression.new("==", Ast::IntegerExpression.new(3),Ast::NilExpression.new()), [Ast::IntegerExpression.new(3)],[Ast::IntegerExpression.new(4)] )
    @root = :conditional
  end

  def pest_simple_if
    @input = <<HERE
if(3 == nil)
  3
end
HERE
    @input.chop!
    @parse_output = {:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"== ", :r=>{:nil=>"nil"}}, :if_true=>{:expressions=>[{:integer=>"3"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"4"}], :end=>"end"}}
    @output = Ast::IfExpression.new(Ast::OperatorExpression.new("==", Ast::IntegerExpression.new(3),Ast::NilExpression.new()), [Ast::IntegerExpression.new(3)],[Ast::IntegerExpression.new(4)] )
    @root = :conditional
  end

  def pest_reverse_if
    @input = "3  if(3 == nil)"
    @parse_output = {:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"== ", :r=>{:nil=>"nil"}}, :if_true=>{:expressions=>[{:integer=>"3"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"4"}], :end=>"end"}}
    @output = Ast::IfExpression.new(Ast::OperatorExpression.new("==", Ast::IntegerExpression.new(3),Ast::NilExpression.new()), [Ast::IntegerExpression.new(3)],[Ast::IntegerExpression.new(4)] )
    @root = :conditional
  end
end
