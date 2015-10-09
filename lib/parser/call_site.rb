module Parser
  module CallSite
    include Parslet

    rule(:r_value) { operator_value | call_site | field_access | basic_type }

    rule(:assign) { str('=') >> space?}
    rule(:assignment){ (field_access|name).as(:l_value) >> assign.as(:assign) >> r_value.as(:r_value) }

    rule(:field_def) { type >> name >> (assign >> r_value.as(:value) ).maybe}

    rule(:argument_list) {
      left_parenthesis >>
      (  (basic_type.as(:argument) >>
          (comma >> r_value.as(:argument)).repeat(0)).repeat(0,1)).as(:argument_list) >>
           right_parenthesis
    }

    rule(:call_site) { (basic_type.as(:receiver) >> str(".")).maybe >> #possibly qualified
                          name.as(:call_site) >> argument_list >> comment.maybe}

  end
end
