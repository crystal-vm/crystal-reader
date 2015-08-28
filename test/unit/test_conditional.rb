require_relative "../parser_helper"

class TestConditional < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_conditional_brackets
    check("(0)")
  end
  def test_conditional_no_brackets
    check("0")
  end

  def check cond
    input = <<HERE

  42
else
  667
end
HERE
    @input = "if #{cond} " + input.chop!
    @parse_output = {:if=>"if", :conditional=>{:integer=>"0"}, :if_true=>{:expressions=>[{:integer=>"42"}], :else=>"else"}, :if_false=>{:expressions=>[{:integer=>"667"}], :end=>"end"}}
    @output = Ast::IfExpression.new(Ast::IntegerExpression.new(0), [Ast::IntegerExpression.new(42)],[Ast::IntegerExpression.new(667)] )
    @root = :conditional
  end

  def test_conditional_with_calls
    @input = <<HERE
if(3 > var)
  Object.initialize(3)
else
  var.new(33)
end
HERE
    @input.chop!
    @parse_output = {:if=>"if", :conditional=>{:l=>{:integer=>"3"}, :o=>"> ", :r=>{:name=>"var"}}, :if_true=>{:expressions=>[{:receiver=>{:module_name=>"Object"}, :call_site=>{:name=>"initialize"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], :else=>"else"}, :if_false=>{:expressions=>[{:receiver=>{:name=>"var"}, :call_site=>{:name=>"new"}, :argument_list=>[{:argument=>{:integer=>"33"}}]}], :end=>"end"}}
    @output = Ast::IfExpression.new(Ast::OperatorExpression.new(">", Ast::IntegerExpression.new(3),Ast::NameExpression.new("var")), [Ast::CallSiteExpression.new(:initialize, [Ast::IntegerExpression.new(3)] ,Ast::ModuleName.new("Object"))],[Ast::CallSiteExpression.new(:new, [Ast::IntegerExpression.new(33)] ,Ast::NameExpression.new("var"))] )
    @root = :conditional
  end

  def test_conditional_nil
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
