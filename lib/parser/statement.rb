module Parser
  module Statement
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

    rule(:statement) { (return_statement | while_statement | small_conditional | if_statement |
                          assignment | class_field | field_def | call_site |
                          hash_constant | array_constant)  }

    def delimited_statements( delimit )
      ( (delimit.absent? >> statement).repeat(1)).as(:statements) >> delimit
    end

    rule(:statements_do)     { delimited_statements(keyword_do) }
    rule(:statements_else)   { delimited_statements(keyword_else) }
    rule(:statements_end)    { delimited_statements(keyword_end) }

  end
end
