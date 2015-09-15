require_relative "../parser_helper"

class TestConditional < MiniTest::Test
  include ParserHelper

  def test_assignment
    @input = "myvar = 42"
    @output = s(:assign, :myvar, s(:int, 42))
    check :assignment
  end

  def test_variable_declaration
    @input = "int myvar"
    @output = s(:variable,s(:type, "int", "myvar"), nil)
    check :variable_definition
  end

  def test_variable_declaration_value
    @input = "int myvar = 42"
    @output = s(:variable,   s(:type, "int", "myvar"),   s(:int, 42))
    check :variable_definition
  end

  def test_if
    @input = <<HERE
if( 1 )
  int num = 42
end
HERE
    @output = s(:if,   s(:cond,     s(:int, 1)),   s(:then, [s(:variable,
                                              s(:type, "int", "num"),
                                              s(:int, 42))]))
    check :conditional
  end

  def test_conditional_with_calls
    @input = <<HERE
if(var)
  42.add(5)
end
HERE
    @output = s(:if,
                s(:cond, "var"),
                s(:then, [s(:call, s(:field, s(:int, 42), "add"), [s(:int, 5)])]))
    check :conditional
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
    @output = nil
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
    @output = nil
    @root = :conditional
  end

end
