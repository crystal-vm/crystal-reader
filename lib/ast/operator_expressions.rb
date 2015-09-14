module Ast

  class OperatorExpression < Expression
    attr_reader  :operator, :left, :right

    def initialize operator, left, right
      @operator, @left, @right = operator, left, right
    end

    def attributes
      [:operator, :left, :right]
    end

    def to_s
      operator.inspect + ", " +  left.inspect + "," + right.inspect
    end
  end

end
