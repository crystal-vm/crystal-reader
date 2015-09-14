module Ast

  class FieldExpression < Expression
    attr_reader  :receiver , :name

    def initialize receiver , name
      @receiver =  receiver
      @name = name.to_sym
    end
    def attributes
      [:receiver , :name]
    end

    def to_s
      receiver.inspect + "," + name.inspect
    end
  end

  class CallSiteExpression < Expression
    attr_reader  :field , :args

    def initialize field, args
      @field = field
      @args = args
    end
    def attributes
      [:field , :args]
    end

    def to_s
      field.inspect + ", ["+
        args.collect{|m| m.inspect }.join( ",") + "] "
    end
  end
end
