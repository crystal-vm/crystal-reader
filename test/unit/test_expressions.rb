require_relative "../parser_helper"

class TestExpressions < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper
    
  def test_expression_else
    @input    = <<HERE
dud
fuu(3)
else
HERE
    @input.chop!
    @parse_output = {:expressions=>[{:name=>"dud"}, 
      {:call_site=>{:name=>"fuu"}, :argument_list=>[{:argument=>{:integer=>"3"}}]}], 
      :else=>"else"}
    @output ={:expressions=>[Ast::NameExpression.new("dud"), 
          Ast::CallSiteExpression.new("fuu", [Ast::IntegerExpression.new(3)] )], :else=>"else"}
    @root = :expressions_else
  end

  def test_expression_end
    @input    = <<HERE
name
call(4,6)
end
HERE
    @input.chop!
    @parse_output = {:expressions=>[{:name=>"name"}, 
      {:call_site=>{:name=>"call"}, :argument_list=>[{:argument=>{:integer=>"4"}}, {:argument=>{:integer=>"6"}}]}], 
      :end=>"end"}
    @output = {:expressions=>[Ast::NameExpression.new("name"), 
      Ast::CallSiteExpression.new("call", [Ast::IntegerExpression.new(4),Ast::IntegerExpression.new(6)] )], 
      :end=>"end"}

    @root = :expressions_end
  end


end