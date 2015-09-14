module Ast
  class ReturnExpression < Expression
    attr_reader  :expression
    def initialize expression
      @expression = expression
    end
    def attributes
      [:expression]
    end

    def to_s
      expression.inspect
    end
  end
end
