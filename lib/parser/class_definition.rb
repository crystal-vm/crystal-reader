module Parser
  module ModuleDef
    include Parslet

    rule(:class_field) { keyword_field >> field_def }

    rule(:class_body) {
      function_definition | class_field
    }
    rule(:class_definition) do
      keyword_class >> class_name >> (str("<") >> space >> class_name).maybe.as(:derived_name) >>
      ( (keyword_end.absent? >> class_body).repeat()).as(:class_statements) >> keyword_end
    end

  end
end
