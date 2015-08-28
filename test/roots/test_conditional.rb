require_relative "../parser_helper"

class RootTestConditional < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_if_else
    @input = <<HERE
if(0)
  42
else
  667
end
HERE
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::IntegerExpression.new(42)],[Ast::IntegerExpression.new(667)] )])
    @root = :
  end

  def test_if_else_expressions
    @input = <<HERE
if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
HERE
    @input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new(:var)), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new(:Object))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new(:var))] )])
  end

  def pest_if_end
    @input = <<HERE
if(0)
  42
end
HERE
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::IntegerExpression.new(42)],[Ast::IntegerExpression.new(667)] )])
    @root = :
  end

  def pest_if_end_expressions
    @input = <<HERE
if(3 > var)
  Object.initialize(3)
end
HERE
    @input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new(:var)), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new(:Object))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new(:var))] )])
  end

  def pest_if_reverse
    @input = "42  if(0)"
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::IntegerExpression.new(42)],[Ast::IntegerExpression.new(667)] )])
    @root = :
  end

  def pest_if_end_expressions
    @input = "Object.initialize(3)  if(3 > var)"
    @input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}]}
    @output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new(:var)), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new(:Object))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new(:var))] )])
  end


end
