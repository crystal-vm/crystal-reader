require_relative "../parser_helper"

class RootTestBlock < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def pest_block
    @string_input = <<HERE
self.call(1) do |a , b|
  tmp = a
  puts(b)
end
HERE
    @parse_output = nil
    @transform_output = nil
    @parser = @parser
  end

  def pest_big_block
    @string_input = <<HERE
self.call( true , false) do | a , b |
  tmp = a
  a = b
  b = tmp + b
  puts(b)
  n = n - 1
end
HERE
    @parse_output = {:expression_list=>[{:while=>"while", :while_cond=>{:l=>{:name=>"n"}, :o=>"> ", :r=>{:integer=>"1"}}, :do=>"do", :body=>{:expressions=>[{:l=>{:name=>"tmp"}, :o=>"= ", :r=>{:name=>"a"}}, {:l=>{:name=>"a"}, :o=>"= ", :r=>{:name=>"b"}}, {:l=>{:name=>"b"}, :o=>"= ", :r=>{:l=>{:name=>"tmp"}, :o=>"+ ", :r=>{:name=>"b"}}}, {:call_site=>{:name=>"puts"}, :argument_list=>[{:argument=>{:name=>"b"}}]}, {:l=>{:name=>"n"}, :o=>"= ", :r=>{:l=>{:name=>"n"}, :o=>"- ", :r=>{:integer=>"1"}}}], :end=>"end"}}]}
    @transform_output = Ast::ExpressionList.new( [Ast::BlockExpression.new(Ast::OperatorExpression.new(">", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)), [Ast::AssignmentExpression.new(Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:a)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:a),Ast::NameExpression.new(:b)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:b),Ast::OperatorExpression.new("+", Ast::NameExpression.new(:tmp),Ast::NameExpression.new(:b))), Ast::CallSiteExpression.new(:puts, [Ast::NameExpression.new(:b)] ,Ast::NameExpression.new(:self)), Ast::AssignmentExpression.new(Ast::NameExpression.new(:n),Ast::OperatorExpression.new("-", Ast::NameExpression.new(:n),Ast::IntegerExpression.new(1)))] )])
    @parser = @parser
  end
end
