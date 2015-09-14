module Ast
  class IfExpression < Expression
    attr_reader  :cond, :if_true, :if_false
    def initialize cond, if_true, if_false
      @cond, @if_true, @if_false = cond, if_true, if_false
    end
    def attributes
      [:cond, :if_true, :if_false]
    end

    def to_s
      cond.inspect + ", " + if_true.inspect +  ","  + if_false.inspect
    end
  end
end
