module Parser
  module CallSite
    include Parslet

    rule(:argument_list) {
      left_parenthesis >>
      (  (basic_type.as(:argument) >>
          (comma >> basic_type.as(:argument)).repeat(0)).repeat(0,1)).as(:argument_list) >>
           right_parenthesis
    }

    rule(:call_site) { (basic_type.as(:receiver) >> str(".")).maybe >> #possibly qualified
                          name.as(:call_site) >> argument_list >> comment.maybe}

    rule(:field_access) { name.as(:receiver) >> str(".") >> name.as(:field) }

  end
end
