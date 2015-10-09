module Parser
  module Statement
    include Parslet

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
