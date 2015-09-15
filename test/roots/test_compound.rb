require_relative "../parser_helper"

class RootTestCompound < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include ParserHelper

  def test_one_array
    @string_input    = '[42]'
    @parse_output = {:expression_list=>[{:array_constant=>[{:array_element=>{:integer=>"42"}}]}]}
    @transform_output = s(:list, [s(:array, [s(:int, 42)])])
  end

  def test_array_list
    @string_input    = '[42, foo]'
    @parse_output = {:expression_list=>[{:array_constant=>[{:array_element=>{:integer=>"42"}}, {:array_element=>{:name=>"foo"}}]}]}
    @transform_output = s(:list, [s(:array, [s(:int, 42), s(:name, "foo")])])
  end

  def test_array_ops
    @string_input    = '[ 3 + 4 , foo(22) ]'
    @parse_output = {:expression_list=>[{:array_constant=>[{:array_element=>{:l=>{:integer=>"3"}, :o=>"+ ", :r=>{:integer=>"4"}}}, {:array_element=>{:call_site=>{:name=>"foo"}, :argument_list=>[{:argument=>{:integer=>"22"}}]}}]}]}
    @transform_output = s(:list, [s(:array, [s(:operator, "+", s(:int, 3), s(:int, 4)), s(:call, s(:name, "foo"), [s(:int, 22)])])])
  end

  def test_hash
    @string_input = '{ foo => 33 }'
    @parse_output = {:expression_list=>[{:hash_constant=>[{:hash_pair=>{:hash_key=>{:name=>"foo"}, :hash_value=>{:integer=>"33"}}}]}]}
    @transform_output = s(:list, [s(:hash, [s(:assoc, s(:name, "foo"), s(:int, 33))])])
  end

  def test_hash2
    @string_input = '{ foo => true }'
    @parse_output = {:expression_list=>[{:hash_constant=>[{:hash_pair=>{:hash_key=>{:name=>"foo"}, :hash_value=>{:true=>"true"}}}]}]}
    @transform_output = s(:list, [s(:hash, [s(:assoc, s(:name, "foo"), s(:true))])])
  end

  def test_hash_list
    @string_input = "{foo => 33 , bar => 42}"
    @parse_output = {:expression_list=>[{:hash_constant=>[{:hash_pair=>{:hash_key=>{:name=>"foo"}, :hash_value=>{:integer=>"33"}}}, {:hash_pair=>{:hash_key=>{:name=>"bar"}, :hash_value=>{:integer=>"42"}}}]}]}
    @transform_output = s(:list, [s(:hash, [s(:assoc, s(:name, "foo"), s(:int, 33)), s(:assoc, s(:name, "bar"), s(:int, 42))])])
  end

end
