module Ast
  class ExpressionList < Expression
    attr_reader  :expressions
    def initialize expressions
      @expressions = expressions
    end
    def attributes
      [:expressions]
    end
    def inspect
      self.class.name + ".new( ["+ expressions.collect(&:inspect).join( ",") +"])"
    end

    def to_s
      expressions.collect(&:inspect).join("\n")
    end
  end
end