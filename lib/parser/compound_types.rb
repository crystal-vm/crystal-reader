module Parser
  # Compound types are Arrays and Hashes
  module CompoundTypes
    include Parslet

    rule(:array_constant) do
      left_bracket >>
      (  ((operator_expression|r_value).as(:array_element) >> space? >>
          (comma >> space? >> (operator_expression|r_value).as(:array_element)).repeat(0)).repeat(0,1)).as(:array_constant) >>
          space? >> right_bracket
      end

    rule(:hash_pair)  { basic_type.as(:hash_key) >> association >> (operator_expression|r_value).as(:hash_value) }
    rule(:hash_constant)       { left_brace >> ((hash_pair.as(:hash_pair) >> 
                         (comma >> space? >> hash_pair.as(:hash_pair)).repeat(0)).repeat(0,1)).as(:hash_constant)>> 
                         space? >> right_brace }

  end
end