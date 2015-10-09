module Parser
  module Control
    include Parslet
    rule(:while_statement) do
      keyword_while  >> left_parenthesis >> r_value.as(:condition)  >>
                              right_parenthesis >> statements_end.as(:body)
    end

    rule(:if_statement) do
      keyword_if >>
       left_parenthesis >> r_value.as(:conditional) >> right_parenthesis >>
        statements_else.as(:true_statements) >> statements_end.as(:false_statements)
    end

    rule(:small_conditional) do
      keyword_if >>
       left_parenthesis >> r_value.as(:conditional) >> right_parenthesis >>
          statements_end.as(:true_statements)
      end

    rule(:return_statement) do
      keyword_return >> r_value.as(:return_statement)
    end
  end
end
