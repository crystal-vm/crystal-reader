module Parser
  module Operators
    include Parslet

    rule(:operator_sym) {
      str('**') | str('*') | str('/') | str('/') | str('%') |
      str('+') | str('-') | str('<<')| str('>>') |
      str('|') | str('&') |
      str('>=') | str('<=') | str('>') | str('<') |
      str('==') | str('!=')   }

      rule(:operator_value) {  (field_access|basic_type).as(:left) >>
          operator_sym.as(:operator) >> space? >> (field_access|basic_type).as(:right) }
  end
end
