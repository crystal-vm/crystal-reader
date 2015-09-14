module Ast
  class FunctionExpression < Expression
    attr_reader  :name, :params, :body , :receiver
    def initialize name, params, body , receiver = nil
      @name = name.to_sym
      @params =  params
      @body = body
      @receiver = receiver
    end
    def attributes
      [:name, :params, :body , :receiver]
    end
    def to_s
      name.inspect + ", ["+
        params.collect{|m| m.inspect }.join( ",") +"] , [" +
        body.collect{|m| m.inspect }.join( ",") +"] ,"+  receiver.inspect
    end
  end
end
