module Ast
  class WhileExpression < Expression
    attr_reader  :condition, :body

    def initialize condition, body
      @condition , @body = condition , body
    end

    def attributes
      [:condition, :body]
    end

    def to_s
      condition.inspect + ", "  + body.inspect  
    end
  end
end
