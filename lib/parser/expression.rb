module Parser
  module Expression
    include output
    
    rule(:value_expression) { call_site | basic_type }

    rule(:expression) { (simple_return | while_do | conditional | operator_expression | call_site ) >> newline }

    def delimited_expressions( delimit )
      ( (delimit.absent? >> expression).repeat(1)).as(:expressions) >> delimit
    end

    rule(:expressions_do)     { delimited_expressions(keyword_do) }
    rule(:expressions_else)   { delimited_expressions(keyword_else) }
    rule(:expressions_end)    { delimited_expressions(keyword_end) }

  end
end
