require_relative "basic_types"
require_relative "compound_types"
require_relative "tokens"
require_relative "keywords"
require_relative "control"
require_relative "expression"
require_relative "call_site"
require_relative "function_definition"
require_relative "module_definition"
require_relative "operators"

module Parser
  
  # obviously a work in progress !!
  # We "compose" the parser from bits, divide and hopefully conquer
   
  # a note about .maybe : .maybe is almost every respect the same as .repeat(0,1)
  # so either 0, or 1, in other words maybe. Nice feature, but there are strings attached:
  # a maybe removes the 0  a sequence (array) to a single (hash). Thus 2 transformations are needed
  # More work than the prettiness is worth, so only use .maybe on something that does not need capturing

  class Salama < Parslet::Parser
    include BasicTypes
    include CompoundTypes
    include Tokens
    include Keywords
    include Control
    include Expression
    include CallSite
    include FunctionDefinition
    include Operators
    include ModuleDef

    rule(:root_body)    {(module_definition | class_definition | function_definition | expression  | 
                          operator_expression | call_site | basic_type | hash_constant | array_constant )}
    rule(:root)         { root_body.repeat.as(:expression_list) }
  end
end
