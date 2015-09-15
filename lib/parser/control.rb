module Parser
  module Control
    include Parslet
    rule(:conditional) do
      keyword_if >>
       left_parenthesis >> (operator_expression|value_expression).as(:conditional) >> right_parenthesis >>
        expressions_else.as(:if_true) >> expressions_end.as(:if_false)
    end

    rule(:small_conditional) do
      keyword_if >>
       left_parenthesis >> (operator_expression|value_expression).as(:conditional) >> right_parenthesis >>
          expressions_end.as(:if_true)
      end

    rule(:while_do) do
      keyword_while  >> left_parenthesis >> (operator_expression|value_expression).as(:while_cond)  >>
                              right_parenthesis >> expressions_end.as(:body)
    end
    rule(:simple_return) do
      keyword_return >> (operator_expression|value_expression).as(:return_expression)
    end
  end
end
