module Parser
  module FunctionDefinition
    include Parslet

    rule(:function_definition) {
      keyword_def >> ((module_name|name).as(:receiver) >> str(".")).maybe >> #possibly qualified
                  name.as(:function_name) >> parameter_list.maybe >> space >> expressions_end >> space?
    }

    rule(:parameter_list) {
      left_parenthesis >>
      ((name.as(:parameter) >> (comma >> name.as(:parameter)).repeat(0)).repeat(0,1)).as(:parameter_list) >>
      right_parenthesis
    }

  end
end
