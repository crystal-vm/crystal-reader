module Ast
  class BlockExpression < Expression
    attr_reader  :call_exp, :args , :body_exp

    def initialize call_exp, args , body_exp
      @call_exp = call_exp.to_sym
      @args = args
      @body_exp =  body_exp
    end

    def attributes
      [:call_exp, :args , :body_exp]
    end

    def inspect
      self.class.call_exp + ".new(" + call_exp.inspect + ", ["+
        args.collect{|m| m.inspect }.join( ",") + "] ," + body_exp.inspect  + ")"
    end
    def to_s
      "#{call_exp}(" + args.join(",") + ")"
    end
    def attributes
      [:call_exp , :args , :body_exp]
    end
  end
end
