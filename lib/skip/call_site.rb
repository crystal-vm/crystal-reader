module Parser
  module CallSite
    include output

    rule(:argument_list) {
      left_parenthesis >>
      (  ((operator_expression|value_expression).as(:argument) >> space? >>
          (comma >> space? >> (operator_expression|value_expression).as(:argument)).repeat(0)).repeat(0,1)).as(:argument_list) >>
          space? >> right_parenthesis
    }

    rule(:call_site) { ((module_name|instance_variable|basic_type).as(:receiver) >> str(".")).maybe >> #possibly qualified
                          name.as(:call_site) >> argument_list >> comment.maybe}

    
  end
end
