require_relative "../parser_helper"

class RootTestConditional < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
  
  def test_conditional_brackets
    @string_input = <<HERE
if(0)
  42
else
  667
end
HERE
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}]}
    @transform_output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::IntegerExpression.new(42)],[Ast::IntegerExpression.new(667)] )])
    @parser = @parser
  end

  def test_conditional_with_calls
    @string_input = <<HERE
if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
HERE
    @string_input
    @parse_output = {:expression_list=>[{:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}]}
    @transform_output = Ast::ExpressionList.new( [Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new(:var)), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new(:Object))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new(:var))] )])
  end
end