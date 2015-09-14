module Ast
  class ExpressionList < Expression
    attr_reader  :expressions
    def initialize expressions
      @expressions = expressions
    end

    def attributes
      [:expressions]
    end

    def to_s
      "["+ expressions.collect(&:inspect).join( ",") +"]"
    end

  end
end
