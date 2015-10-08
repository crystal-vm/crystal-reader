module Parser
  module ModuleDef
    include Parslet

    rule(:class_definition) do
      keyword_class >> class_name >> (smaller >> class_name).maybe.as(:derived_name) >>
      ( (keyword_end.absent? >> root_body).repeat()).as(:class_expressions) >> keyword_end
    end

  end
end
