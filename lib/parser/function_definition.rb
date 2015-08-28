module Parser
  module FunctionDefinition
    include output
    
    rule(:function_definition) {
      keyword_def >> ((module_name|instance_variable|name).as(:receiver) >> str(".")).maybe >> #possibly qualified
                  name.as(:function_name) >> parameter_list.maybe >> newline >> expressions_end >> newline
    }

    rule(:parameter_list) {
      left_parenthesis >>
      ((name.as(:parameter) >> (comma >> name.as(:parameter)).repeat(0)).repeat(0,1)).as(:parameter_list) >>
      right_parenthesis
    }

  end
end
