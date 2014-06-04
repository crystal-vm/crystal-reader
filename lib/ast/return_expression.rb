module Ast
  class ReturnExpression < Expression
    attr_reader  :expression
    def initialize expression
      @expression = expression
    end
    def inspect
      self.class.name + ".new(" + expression.inspect + " )"  
    end
    def to_s
      "return #{expression}\n"
    end
    def attributes
      [:expression]
    end
  end
end